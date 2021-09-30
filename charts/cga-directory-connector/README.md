# cga-directory-connector

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Barracuda CloudGen Access Directory Connector

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add barracuda-cloudgen-access https://barracuda-cloudgen-access.github.io/helm-charts
$ helm install my-release barracuda-cloudgen-access/cga-directory-connector
```

## URLs

**Homepage:** <https://github.com/barracuda-cloudgen-access/helm-charts>

**Documentation:** <https://campus.barracuda.com/product/cloudgenaccess/doc/93201549/user-directory-connector>

**Product homepage:** <https://www.barracuda.com/products/cloudgen-access>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| authToken.existingSecret.key | string | `""` | Existing secret key |
| authToken.existingSecret.name | string | `""` | Existing secret resource name |
| authToken.newSecret.value | string | `""` | Enrollment token value to be created with new secret |
| authToken.type | string | `""` | Available directory types: azure/google/okta |
| commonPodAnnotations | object | `{}` | Provide pod annotations that all pods will use |
| customEnv | list | `[]` | Configure directory-connector with environment variables. <https://campus.barracuda.com/product/cloudgenaccess/doc/93201555/parameters/> |
| enrollmentToken.existingSecret.key | string | `""` | Existing secret key |
| enrollmentToken.existingSecret.name | string | `""` | Existing secret resource name |
| enrollmentToken.newSecret.value | string | `""` | Enrollment token value to be created with new secret |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pullPolicy |
| image.repository | string | `"fydeinc/fyde-connector"` | Docker image to use |
| image.sha256 | string | `"90f0c16cea2c5fcd8127c76d03d9eaa6e6bfa47de84a267b51467a6b3471556d"` | Docker image checksum |
| image.tag | string | `"1.3.17"` | Docker image tag |
| logLevel | string | `"info"` | Log level to use. Valid values: error/warning/info/debug |
| nameOverride | string | `""` | Provide a name in place of cga-directory-connector for labels |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` | Set priorityClassName |
| resources | object | `{}` | Recomended resources for initial deployment |
| revisionHistoryLimit | int | `10` | Set revision history limit |
| securityContext | object | `{}` |  |
| service.port.metrics | int | `9000` | Port number to serve prometheus metrics |
| serviceMonitor | bool | `false` | Create service monitor resources |
| tolerations | list | `[]` |  |
