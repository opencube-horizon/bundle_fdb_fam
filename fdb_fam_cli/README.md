# FDB CLI Tools to Manage Data on FAM

This is an example use-case that demonstrates the FDB CLI tools and the OpenFAM API. The tools allow users to configure, archive, retrieve, and validate GRIB data within the FDB database.

<!-- Ensure that FDB is built with OpenFAM support. -->

## Configuration

The schema location, storage type, and the endpoints for the FAM storage are specified in the configuration file, [config.yml](config.yml).
In the following configuration, FDB uses `./database` for indexing and OpenFAM interface endpoint `10.115.3.2:8080` for storing the bulk data.

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
- uri: "fam://10.115.3.2:8080/demo_fdb_fam_region"
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
   date=20201102,
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

### Retrieve

To retrieve GRIB data from the FDB database, use the `fdb-read` CLI tool as shown below:

```bash
fdb-read --config=config.yml --raw request out.grib
```

Refer to the [FDB Configuration](#fdb-configuration) section for details on the `config.yml` file.

### Validation

To ensure data integrity for written and retrieved files, we can compare the input and output GRIB files.
This can be done by using the `md5sum` command, which generates and checks MD5 hashes to verify the integrity of files.

```bash
md5sum in.grib out.grib
```
