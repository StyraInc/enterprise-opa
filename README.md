# Styra Load

Built by the creators and maintainers of [Open Policy Agent](https://www.openpolicyagent.org/) (OPA), Styra Load is the only enterprise-grade authorization engine built to provide resource-efficient performance for data-heavy workloads while connecting natively to your existing data sources.

Styra Load is designed to offer:

- Reduced costs of data-heavy authorization: Styra Load allows you to reduce OPA’s memory overhead by 10x and gain the ability to get 40% more CPU throughput at the policy decision point.
- Increase integration speed: By offering the ability to natively connect to existing data sources without custom code, Styra Load allows teams to reduce development costs and get into production quickly.
- Minimize risk with powerful analysis: Extending the industry’s only impact analysis tool, Styra Load allows policy validation early and throughout the policy lifecycle, shrinking deployment failure, and costly issues before enforcement. (Coming soon)

## About This Repository

This repository provides:

* The Styra Load [binaries](https://github.com/StyraInc/load/releases/)
* The Styra Load [Docker images](https://github.com/StyraInc/load/pkgs/container/load)
* Example code and deployment blueprints for Styra Load

For Styra Load documentation, see [docs.styra.com](https://docs.styra.com/load)

## Getting started

Styra Load can run either as a standalone executable, or containerized with Docker.

### Download Styra Load

1. Grab the latest version of Styra Load from the [releases](https://github.com/StyraInc/load/releases/) page
1. Untar the archive (unzip on Windows)
1. (Optionally) verify the checksum for the downloaded binary

**Or** download the Load container image:

```shell
docker pull ghcr.io/styrainc/load:latest
```

### Obtaining a License

Running Styra Load requires a valid license key. To evaluate Styra Load, a free 14 day trial license may be obtained from [here](https://www.styra.com/free-trial-14/).

The license key can either be provided the `load` command via an environment variable:

```shell
export STYRA_LOAD_LICENSE_KEY=<license key here>
```

Or via the filesystem using the `--license-key` flag:

```shell
load run --server --license-key <path to file containing license key here> ...
```

### Running Load

Run the Styra `load` binary same as you would run `opa`:

```shell
load run --server ...
```

```shell
load eval ...
```

### Running Load with Docker

```shell
docker run -v $(pwd):/load -w /load ghcr.io/styrainc/load:latest run --config-file /load/load-conf.yml
```

## Examples

This repository additionally contains companion examples and blueprints from the Styra Load [documentation](https://docs.styra.com/load).

- [Performance testing](/examples/performance-testing/)
- Streaming data from [Apache Kafka](/examples/kafka/)
