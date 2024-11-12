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

## Rule

```yaml
[ institute, user [ date [ level, param ] ] ]
```

### Attributes:

- **institute**: Represents the organization or institution responsible for the data.
- **user**: Identifies the user or entity that generated the data.
- **date**: Represents the date when the data was generated or recorded, adding a temporal dimension to the schema.
- **level**: Indicates the level or depth of the data, which can be used for hierarchical organization.
- **param**: Defines specific parameters or variables associated with the data.

## Request

The following request is used to retrieve data from FDB database.

```bash
   institute=ECMWF,
   user=metin,
   date=11112024,
   level=0,
   param=temperature,
```

## Usage

This example project uses CMake to build the source code.

> [!IMPORTANT]
> FDB library must be built with OpenFAM support before.

```bash
# configure
cmake -DCMAKE_PREFIX_PATH="/path/to/fdb_openfam_install" -S . -B ./build

# build
cmake --build ./build
```

## Archive

The `archive` is an application that puts data into the FDB database (POSIX + OpenFAM).

The options below can be set:

```bash
--user <value> --institute <value> --type <value> --param <value> --level <value>
```

Example:

```bash
./build/archive -t test
```

## Retrieve

The `retrieve` is an application that gets data from the FDB database (POSIX + OpenFAM) and saves it into file given by user.

The options below can be set:

```bash
--user <value> --institute <value> --type <value> --param <value> --level <value> --output_file <value>
```

Example:

```bash
./build/retrieve -t test -p temperature -l 3 -o out.data
```
