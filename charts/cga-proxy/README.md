# cga-proxy

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Barracuda CloudGen Access Proxy

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add barracuda-cloudgen-access https://barracuda-cloudgen-access.github.io/helm-charts
$ helm install my-release barracuda-cloudgen-access/cga-proxy
```

## URLs

**Homepage:** <https://github.com/barracuda-cloudgen-access/helm-charts>

**Documentation:** <https://campus.barracuda.com/product/cloudgenaccess/doc/93201588/cloudgen-access-proxy>

**Product homepage:** <https://www.barracuda.com/products/cloudgen-access>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://dandydeveloper.github.io/charts | redis-ha | 4.12.9 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonPodAnnotations | object | `{}` | Provide pod annotations that all pods will use |
| envoy.customEnv | list | `[]` | Configure envoy with environment variables. <https://campus.barracuda.com/product/cloudgenaccess/doc/93201605/access-proxy-parameters> |
| envoy.image.pullPolicy | string | `"IfNotPresent"` | Docker image pullPolicy |
| envoy.image.repository | string | `"fydeinc/envoyproxy-centos"` | Docker image to use |
| envoy.image.sha256 | string | `"5504668542ab15808be4580ea40ace90ca849579ef7eb299542e9c4d4f4d4b2a"` | Docker image checksum |
| envoy.image.tag | string | `"1.13.4.2"` | Docker image tag |
| envoy.loadBalancer.annotations | object | `{}` | Specify required annotations to configure load balancer |
| envoy.loadBalancer.enabled | bool | `false` | Set to true to deploy a load balancer |
| envoy.loadBalancer.externalTrafficPolicy | string | `"Local"` | Set externalTrafficPolicy for the load balancer service. "Local" is recomended to ensure minimum hops. change to "Cluster" if you experience network issues |
| envoy.loadBalancer.port | int | `443` | Set load balancer external port. Must match the one defined on CloudGen Access Console |
| envoy.nodeSelector | object | `{}` |  |
| envoy.podAnnotations | object | `{}` |  |
| envoy.podSecurityContext | object | `{}` |  |
| envoy.replicaCount | int | `1` | Number of replicas for deployment. Envoy can scale as desired |
| envoy.resources | object | `{}` | Recomended resources for initial deployment |
| envoy.securityContext | object | `{}` |  |
| envoy.service.port.listener | int | `8000` | Port number to serve listener service |
| envoy.service.port.metrics | int | `9000` | Port number to serve prometheus metrics |
| envoy.tolerations | list | `[]` |  |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| http-test.enabled | bool | `false` | Enabling http-test creates a deployment with an nginx pod serving a simple http page |
| http-test.image.pullPolicy | string | `"IfNotPresent"` | Docker image pullPolicy |
| http-test.image.repository | string | `"fydeinc/http-test"` | Docker image to use |
| http-test.image.sha256 | string | `""` | Docker image checksum |
| http-test.image.tag | string | `"latest"` | Docker image tag |
| http-test.nodeSelector | object | `{}` |  |
| http-test.podAnnotations | object | `{}` |  |
| http-test.podSecurityContext | object | `{}` |  |
| http-test.resources | object | `{"limits":{"cpu":"10m","memory":"16M"},"requests":{"cpu":"10m","memory":"16M"}}` | Recomended resources for deployment |
| http-test.securityContext | object | `{}` |  |
| http-test.service.port.http | int | `80` | Port number to serve http service |
| http-test.tolerations | list | `[]` |  |
| nameOverride | string | `""` | Provide a name in place of cga-proxy for labels |
| orchestrator.customEnv | list | `[]` | Configure orchestrator with environment variables. <https://campus.barracuda.com/product/cloudgenaccess/doc/93201605/access-proxy-parameters> |
| orchestrator.enrollmentToken.existingSecret.key | string | `""` | Existing secret key |
| orchestrator.enrollmentToken.existingSecret.name | string | `""` | Existing secret resource name |
| orchestrator.enrollmentToken.newSecret.value | string | `""` | Enrollment token value to be created with new secret |
| orchestrator.highAvailability.enabled | bool | `false` | Enabling high availability will deploy a redis cluster. To use an existing redis cluster provide redis settings with environment variables instead |
| orchestrator.image.pullPolicy | string | `"IfNotPresent"` | Docker image pullPolicy |
| orchestrator.image.repository | string | `"fydeinc/fydeproxy-centos"` | Docker image to use |
| orchestrator.image.sha256 | string | `"4a4a367eaef1240d6e49cbefd2c44206530d32425b64d569419c784cb3a7092b"` | Docker image checksum |
| orchestrator.image.tag | string | `"1.3.7"` | Docker image tag |
| orchestrator.nodeSelector | object | `{}` |  |
| orchestrator.podAnnotations | object | `{}` |  |
| orchestrator.podSecurityContext | object | `{}` |  |
| orchestrator.replicaCount | int | `1` | Number of replicas for deployment. If orchestrator.highAvailability.enabled is "true" this value is incremented by one |
| orchestrator.resources | object | `{}` | Recomended resources for initial deployment |
| orchestrator.securityContext | object | `{}` |  |
| orchestrator.service.port.grpc | int | `50051` | Port number to serve grpc service |
| orchestrator.service.port.metrics | int | `9010` | Port number to serve prometheus metrics |
| orchestrator.tolerations | list | `[]` |  |
| priorityClassName | string | `""` | Set priorityClassName for envoy and orchestrator |
| redis-ha | object | Required values are pre-configured. | Only used when orchestrator.highAvailability.enabled is "true". All parameters: <https://github.com/DandyDeveloper/charts/blob/master/charts/redis-ha/values.yaml> |
| redis-ha.exporter.resources | object | `{}` | Recomended resources for initial deployment |
| redis-ha.exporter.serviceMonitor.enabled | bool | `false` | Set to true to create a serviceMonitor resource |
| redis-ha.hardAntiAffinity | bool | `false` | Recomended to set to true in production |
| redis-ha.redis.resources | object | `{}` | Recomended resources for initial deployment |
| redis-ha.replicas | int | `3` | Replicas number for each component. Minimum required is 3 |
| redis-ha.sentinel.resources | object | `{}` | Recomended resources for initial deployment |
| revisionHistoryLimit | int | `10` | Set revision history limit |
| serviceMonitor | bool | `false` | Create service monitor resources |
