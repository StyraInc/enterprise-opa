![OPA v1.3.0](https://img.shields.io/endpoint?url=https://openpolicyagent.org/badge-endpoint/v1.3.0) [![Regal v0.32.0](https://img.shields.io/github/v/release/styrainc/regal?filter=v0.32.0&label=Regal)](https://github.com/StyraInc/regal/releases/tag/v0.32.0)


# Styra Enterprise OPA

![Styra](./content/img/logo.png)

Built by the creators and maintainers of [Open Policy Agent](https://www.openpolicyagent.org/) (OPA), Styra Enterprise OPA is the only enterprise-grade authorization engine built to provide resource-efficient performance for data-heavy workloads while connecting natively to your existing data sources.

Styra Enterprise OPA is designed to offer:

- Reduced costs of data-heavy authorization: Styra Enterprise OPA allows you to reduce OPA’s memory overhead by 10x and gain the ability to get 40% more CPU throughput at the policy decision point.
- Increase integration speed: By offering the ability to natively connect to existing data sources without custom code, Styra Enterprise OPA allows teams to reduce development costs and get into production quickly.
- Minimize risk with powerful analysis: Extending the industry’s only impact analysis tool, Styra Enterprise OPA allows policy validation early and throughout the policy lifecycle, shrinking deployment failure, and costly issues before enforcement.

## 👋 Hello World!

![Hello World](./content/img/helloworld.gif)

<details>
  <summary><strong>Try it out!</strong></summary>

1. `brew install styrainc/packages/eopa`
2. `export EOPA_LICENSE_KEY=<your license key>`
3. `eopa run -s https://dl.styra.com/enterprise-opa/bundle-enterprise-opa-400.tar.gz`
4. `curl 'http://localhost:8181/metrics/alloc_bytes?pretty=true'`

To compare with OPA:

1. `opa run -s -a localhost:8282 https://dl.styra.com/enterprise-opa/bundle-opa-400.tar.gz`
2. `curl 'http://localhost:8282/metrics/alloc_bytes?pretty=true'`

Note: both Styra Enterprise OPA and OPA will show "peak" memory usage if queried just after
launch, so waiting a few minutes before checking the metrics will provide numbers
closer to real-world use.

</details><br/>

## 📖 About This Repository

This repository provides:

* The Styra Enterprise OPA [Docker images](https://github.com/StyraInc/enterprise-opa/pkgs/container/enterprise-opa)
* The Styra Enterprise OPA [binaries](https://github.com/StyraInc/enterprise-opa/releases/)
* Example code and deployment blueprints for Styra Enterprise OPA

For Styra Enterprise OPA documentation, see [docs.styra.com](https://docs.styra.com/enterprise-opa)

## 🏃 Getting Started

Styra Enterprise OPA can run either containerized with Docker, or as a standalone executable.

### ⬇️ Download Styra Enterprise OPA

**MacOS and Linux**
```shell
brew install styrainc/packages/eopa
```

<details>
  <summary><strong>Manual download options</strong></summary>

**MacOS (Apple Silicon)**
```shell
curl -L -o eopa "https://github.com/StyraInc/enterprise-opa/releases/latest/download/eopa_Darwin_arm64"
xattr -d com.apple.quarantine eopa
chmod +x eopa
```

**MacOS (x86_64)**
```shell
curl -L -o eopa "https://github.com/StyraInc/enterprise-opa/releases/latest/download/eopa_Darwin_x86_64"
xattr -d com.apple.quarantine eopa
chmod +x eopa
```

**Linux (x86_64)**
```shell
curl -L -o eopa "https://github.com/StyraInc/enterprise-opa/releases/latest/download/eopa_Linux_x86_64"
chmod +x eopa
```

**Windows**
```shell
curl.exe -L -o eopa.exe "https://github.com/StyraInc/enterprise-opa/releases/latest/download/eopa_Windows_x86_64.exe"
```

See all versions, and checksum files, at the Styra Enterprise OPA [releases](https://github.com/StyraInc/enterprise-opa/releases/) page.

</details><br/>


Alternatively, download the Styra Enterprise OPA Docker image:

```shell
docker pull ghcr.io/styrainc/enterprise-opa:latest
```

Checksums for all binaries may optionally be retrieved from [here](https://github.com/StyraInc/enterprise-opa/releases/latest/download/checksums.txt).

### 🔑 Obtaining a License

Running Styra Enterprise OPA requires a valid license key. To evaluate Styra Enterprise OPA, a free 14 day trial license may be obtained from [here](https://www.styra.com/free-trial-14/?utm_medium=community_u&utm_source=github).

The license key can either be provided the `eopa` command via an environment variable:

```shell
export EOPA_LICENSE_KEY=<license key here>
```

Or via the filesystem using the `--license-key` flag:

```shell
eopa run --server --license-key <path to file containing license key here> ...
```

### 🐳 Running Enterprise OPA with Docker

```shell
docker run -v $(pwd):/enterprise-opa -w /enterprise-opa ghcr.io/styrainc/enterprise-opa:latest run --config-file /enterprise-opa/enterprise-opa-conf.yml
```

### ⚡ Running the Enterprise OPA Binary

Run the Styra `eopa` binary same as you would run `opa`:

```shell
eopa run --server --license-key  ...
```

```shell
eopa eval --data policy.rego --input input.json ...
```

## 🖋️ Examples

This repository additionally contains companion examples and blueprints from the Styra Enterprise OPA [documentation](https://docs.styra.com/enterprise-opa).

- [Performance testing](/examples/performance-testing/)
- Kubernetes [deployment example](/examples/kubernetes/)
- Streaming data from [Apache Kafka](/examples/kafka/)

## 🗣️ Community

For questions, discussions and announcements related to Styra products, services and open source projects, please join the Styra community on [Slack](https://communityinviter.com/apps/styracommunity/signup)!
