# ☸ Helm charts for Barracuda CloudGen Access

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/barracuda-cga-helm-charts)](https://artifacthub.io/packages/search?repo=barracuda-cga-helm-charts)
![Release Charts](https://github.com/barracuda-cloudgen-access/helm-charts/workflows/Release%20Charts/badge.svg?branch=main)

## Usage

[Helm](https://helm.sh) needs to be installed to use the charts.
Refer to Helm's [documentation](https://helm.sh/docs/) for more information.

Add the repo as follows:

```sh
helm repo add barracuda-cloudgen-access https://barracuda-cloudgen-access.github.io/helm-charts
```

You can then run `helm search repo barracuda-cloudgen-access` to see the charts.

## Charts

- [CloudGen Access Proxy](./charts/cga-proxy/README.md)

## Actions

- Create chart docs: `make helm-docs`
- Lint: `make lint`

## Contributing

The charts can be found on Github: <https://github.com/barracuda-cloudgen-access/helm-charts>

## Reporting issues

You can see existing issues and report new ones on [GitHub](https://github.com/barracuda-cloudgen-access/helm-charts/issues).

## License

Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0), a OSI-approved license.

## DISCLAIMER

All of the source code on this repository is provided "as is", without warranty of any kind,
express or implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement. in no event shall Barracuda be liable for any claim,
damages, or other liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the source code.
