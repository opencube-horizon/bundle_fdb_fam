# Data Management on Fabric-Attached Memory (FAM)

This work showcases data management on disaggregated Fabric-Attached Memory (FAM).

We leverage the [ECMWF's FDB](https://github.com/ecmwf/fdb) and [OpenFAM](https://openfam.github.io) to efficiently manage large datasets.
The FDB ensures that the data is semantically organized and easily accessible, making it a robust solution for handling large datasets.
By utilizing the OpenFAM API, the project showcases the performance and scalability in a distributed memory environment.

> [!TIP]
> Fabric-Attached Memory is a type of memory architecture where memory is decoupled from the processor and connected via a high-speed fabric network. This allows for flexible and scalable memory usage, as memory resources can be dynamically allocated and accessed by different processors or nodes in a distributed system.

## FDB Configuration

The configuration file `config.yml` is used to set up the FDB database to work with OpenFAM. It specifies the schema location, storage type, and the endpoints for the FAM storage.
In the following configuration, FDB uses `./database` for indexing and OpenFAM interface endpoint for the bulk data.

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
- uri: "fam://host:port/my_fam_region"
```

## FDB Schema

The schema defines the structure of the FDB databases, which specifies how data are organized (and indexed) for efficient retrieval via rules.
The rule is hierarchical, with three levels of attributes that can be grouped and typed.

```yaml
# example FDB schema

[a1, a2, a3 ...
  [b1, b2, b3... [c1, c2, c3...]]
  [B1, B2, B3... [C1, C2, C3...]]
]

[ institute, user [ date [ level, parameter ] ] ]
```

### Example Rule

```yaml
[ institute, user [ date [ level, parameter ] ] ]
```

#### Attributes:

- **institute**: Represents the organization or institution responsible for the data.
- **user**: Identifies the user or entity that generated the data.
- **date**: Represents the date when the data was generated or recorded, adding a temporal dimension to the schema.
- **level**: Indicates the level or depth of the data, which can be used for hierarchical organization.
- **parameter**: Defines specific parameters or variables associated with the data.

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

In applying this license, ECMWF does not waive the privileges and immunities granted to it by virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.

## Acknowledgments

This work was done as part of the Horizon Europe programme funded project [OpenCUBE](https://horizon-opencube.eu) (grant agreement: 101092984).

<img src="https://rea.ec.europa.eu/sites/default/files/styles/oe_theme_medium_2x_no_crop/public/2021-04/EN-Funded%20by%20the%20EU-POS.jpg" width="200" />
