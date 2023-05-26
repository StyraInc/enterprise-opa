# Styra Load

![Styra](./content/img/logo.png)

Built by the creators and maintainers of [Open Policy Agent](https://www.openpolicyagent.org/) (OPA), Styra Load is the only enterprise-grade authorization engine built to provide resource-efficient performance for data-heavy workloads while connecting natively to your existing data sources.

Styra Load is designed to offer:

- Reduced costs of data-heavy authorization: Styra Load allows you to reduce OPA’s memory overhead by 10x and gain the ability to get 40% more CPU throughput at the policy decision point.
- Increase integration speed: By offering the ability to natively connect to existing data sources without custom code, Styra Load allows teams to reduce development costs and get into production quickly.
- Minimize risk with powerful analysis: Extending the industry’s only impact analysis tool, Styra Load allows policy validation early and throughout the policy lifecycle, shrinking deployment failure, and costly issues before enforcement. (Coming soon)

## 👋 Hello World!

![Hello World](./content/img/helloworld.gif)

<details>
  <summary><strong>Try it out!</strong></summary>

1. `brew install styrainc/packages/load`
2. `export STYRA_LOAD_LICENSE_KEY=<your license key>`
3. `load run -s https://dl.styra.com/load/bundle-load-400.tar.gz`
4. `curl 'http://localhost:8181/metrics/alloc_bytes?pretty=true'`

To compare with OPA:

1. `opa run -s -a localhost:8282 https://dl.styra.com/load/bundle-opa-400.tar.gz`
2. `curl 'http://localhost:8282/metrics/alloc_bytes?pretty=true'`

Note: both Styra Load and OPA will show "peak" memory usage if queried just after
launch, so waiting a few minutes before checking the metrics will provide numbers
closer to real-world use.

</details><br/>

## 📖 About This Repository

This repository provides:

* The Styra Load [Docker images](https://github.com/StyraInc/load/pkgs/container/load)
* The Styra Load [binaries](https://github.com/StyraInc/load/releases/)
* Example code and deployment blueprints for Styra Load

For Styra Load documentation, see [docs.styra.com](https://docs.styra.com/load)

## 🏃 Getting Started

Styra Load can run either containerized with Docker, or as a standalone executable.

### ⬇️ Download Styra Load

**MacOS and Linux**
```shell
brew install styrainc/packages/load
```

<details>
  <summary><strong>Manual download options</strong></summary>

**MacOS (Apple Silicon)**
```shell
curl -L -o load "https://github.com/StyraInc/load/releases/latest/download/load_Darwin_arm64"
xattr -d com.apple.quarantine load
chmod +x load
```

**MacOS (x86_64)**
```shell
curl -L -o load "https://github.com/StyraInc/load/releases/latest/download/load_Darwin_x86_64"
xattr -d com.apple.quarantine load
chmod +x load
```

**Linux (x86_64)**
```shell
curl -L -o load "https://github.com/StyraInc/load/releases/latest/download/load_Linux_x86_64"
chmod +x load
```

**Windows**
```shell
curl.exe -L -o load.exe "https://github.com/StyraInc/load/releases/latest/download/load_Windows_x86_64.exe"
```

See all versions, and checksum files, at the Styra Load [releases](https://github.com/StyraInc/load/releases/) page.

</details><br/>


Alternatively, download the Styra Load Docker image:

```shell
docker pull ghcr.io/styrainc/load:latest
```

Checksums for all binaries may optionally be retrieved from [here](https://github.com/StyraInc/load/releases/latest/download/checksums.txt).

### 🔑 Obtaining a License

Running Styra Load requires a valid license key. To evaluate Styra Load, a free 14 day trial license may be obtained from [here](https://www.styra.com/free-trial-14/?utm_medium=community_u&utm_source=github).

The license key can either be provided the `load` command via an environment variable:

```shell
export STYRA_LOAD_LICENSE_KEY=<license key here>
```

Or via the filesystem using the `--license-key` flag:

```shell
load run --server --license-key <path to file containing license key here> ...
```

### 🐳 Running Load with Docker

```shell
docker run -v $(pwd):/load -w /load ghcr.io/styrainc/load:latest run --config-file /load/load-conf.yml
```

### ⚡ Running the Load Binary

Run the Styra `load` binary same as you would run `opa`:

```shell
load run --server --license-key  ...
```

```shell
load eval --data policy.rego --input input.json ...
```

## 🖋️ Examples

This repository additionally contains companion examples and blueprints from the Styra Load [documentation](https://docs.styra.com/load).

- [Performance testing](/examples/performance-testing/)
- Kubernetes [deployment example](/examples/kubernetes/)
- Streaming data from [Apache Kafka](/examples/kafka/)

## 🗣️ Community

For questions, discussions and announcements related to Styra products, services and open source projects, please join the Styra community on [Slack](https://join.slack.com/t/styracommunity/shared_invite/zt-1vzb60ikx-F6ht2yi5uI0c_P_1z3r1sw)!
