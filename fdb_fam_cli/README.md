# FDB CLI Tools to Manage Data on FAM

This is an example use-case that demonstrates the FDB CLI tools and the OpenFAM API. The tools allow users to configure, archive, retrieve, and validate GRIB data within the FDB database.

> [!IMPORTANT]
> Ensure that FDB is built with OpenFAM support.

## Environment setup

OpenFAM services running on OpenCUBE systems are,

```bash
Service             Id  Host          RPC Port
----------------  ----  ----------  ----------
memory service       0  10.115.3.1        8790
memory service       1  10.115.3.2        8791
metadata service     0  10.115.3.1        8787
CIS                  0  10.115.3.1        8780
```

where `10.115.3.1` is infra1 and `10.115.3.2` is infra2. The following are the relevant environment variables,

```bash
# OpenFAM configs
export OPENFAM_ROOT="/shared/members/ECMWF/software/fam/$HOSTTYPE"

# OpenFAM libraries
export OPENFAM_INSTALL_DIR="/shared/WP/3/OpenFam/$HOSTTYPE/install"
export LD_LIBRARY_PATH="$OPENFAM_INSTALL_DIR/lib:$OPENFAM_INSTALL_DIR/lib64:/opt/cray/libfabric/1.20.1/lib64:$LD_LIBRARY_PATH"

# FDB binaries
export PATH="/path_to_bundle/build/$HOSTTYPE/bin/:$PATH"
```

If `HOSTTYPE` is missing, `export HOSTTYPE=$(uname -m)`.

## Configuration

The schema location, storage type, and the endpoints for the FAM storage are specified in the configuration file, [config.yml](config.yml).
In the following configuration, FDB uses `./database` for indexing and OpenFAM interface endpoint `10.115.3.1:8780` for storing the bulk data.

```yaml
---
schema: ./schema
type: local
engine: toc
store: fam
spaces:
- handler: Default
  roots:
  - path: ./database
fam_roots:
- uri: "fam://10.115.3.1:8780/demo_fdb_fam_region"
```

## Schema

```yaml
[ class, expver, stream=oper/dcda/scda, date, time, domain
       [ type, levtype
               [ step, levelist?, param ]]
]
```

### Attributes:

* `class`: Represents the classification of the data.
* `expver`: Experiment version identifier.
* `stream`: Data stream, which can be one of `oper`, `dcda`, or `scda`.
* `date`: The date of the data.
* `time`: The time of the data.
* `domain`: The domain of the data.
* `type`: The type of data.
* `levtype`: The level type of the data.
* `step`: The forecast step.
* `levelist?`: Level of the data (Optional).
* `param`: The parameter name of the data.

## Request

The following request is used to retrieve GRIB data from FDB database.

```bash
retrieve,
   class=rd,
   expver=xxxx,
   stream=oper,
   date=20241126,
   time=0000,
   type=fc,
   levtype=sfc,
   step=012,
   domain=g,
   param=166,
   target="out.grib"
```

## Usage

### Archive

To write GRIB data (`in.grib`) into the FDB database, use the `fdb-write` CLI tool as shown below:

```bash
fdb-write --config=config.yml in.grib
```

Refer to the [FDB Configuration](#fdb-configuration) section for details on the `config.yml` file.
The successful output message would look like the following,

Sample output message:
```bash
Processing in.grib
FDB archive 1 message, size 1.44141 Kbytes, in 0.0708 second (20.3577 Kbytes per second)
fdb::service::archive: 0.071014 second elapsed, 0.054167 second cpu
```

The FDB catalogue creates the database `rd:xxxx:oper:20241126:0000:g`,

```bash
rd:xxxx:oper:20241126:0000:g/schema
rd:xxxx:oper:20241126:0000:g/toc
rd:xxxx:oper:20241126:0000:g/sfc.20241126.135920.infra1.114009906872321.index
```

while the bulk data `in.grib` is stored on FAM as object.

### Retrieve

To retrieve GRIB data (`out.grib`) from the FDB database, use the `fdb-read` CLI tool as shown below:

```bash
fdb-read --config=config.yml --raw request out.grib
```

Refer to the [FDB Configuration](#fdb-configuration) section for details on the `config.yml` file.

Sample output message:
```bash
retrieve,class=rd,expver=xxxx,stream=oper,date=20241126,time=0000,type=fc,levtype=sfc,step=012,domain=g,param=166,target=out.grib
```

Then, the FDB store creates the bulk data `out.grib` under current directory.

### Validation

To ensure data integrity for written and retrieved files, we can compare the input and output GRIB files.
This can be done by using the `md5sum` command, which generates and checks MD5 hashes to verify the integrity of files.

```bash
md5sum in.grib out.grib
```
