# EthQuokkaOps Helm Charts

[![Release Helm Charts](https://github.com/EthDevOps/helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/EthDevOps/helm-charts/actions/workflows/release.yaml)

A set of [Helm](https://helm.sh/) charts to run multiple components of the [Ethereum Foundations](https://ethereum.org/) internal stack on [Kubernetes](https://kubernetes.io/).

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```sh
helm repo add ethquokkaops-helm-charts https://ethdevops.github.io/ethquokkaops-helm-charts
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run the following command to see the charts.

```sh
helm search repo ethquokkaops-helm-charts
```

To install the discord-backup-bot chart:

```sh
helm install discord-backup-bot ethquokkaops-helm-charts/ethstats
```

To uninstall the chart:

```sh
helm delete discord-backup-bot
```

## List of charts

- [`discord-backup-bot`](charts/discord-backup-bot) - Deploys the Discord backup bot to grab message backups from discord servers

## Development

### Prerequisites

- [`pre-commit`](https://pre-commit.com/) - Used to setup pre-commit git hooks
- [`docker`](https://www.docker.com/) - Used by many Makefile targets

### Pre-commit hooks

This repository used [`pre-commit`](https://pre-commit.com/) to manage and run certain git hooks. Hook definitions can be found within the [`.pre-commit-config.yaml`](.pre-commit-config.yaml) file.

Run the following to add the hooks to your local repository:

```sh
make init
```

### Useful commands

The `README` for every chart is auto generated using [helm-docs](https://github.com/norwoodj/helm-docs). This is defined as a pre-commit hook. If you want to run it manually, you can run:

```sh
make docs
```

The [CT (Chart Testing)](https://github.com/helm/chart-testing) tool is used to lint and validate charts. You can run this via:

```sh
make lint
```

## License

[MIT License](LICENSE)
