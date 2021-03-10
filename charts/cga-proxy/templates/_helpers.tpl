{{/*
Expand the name of the chart.
*/}}
{{- define "cga-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cga-proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Fullname suffixed with orchestrator
*/}}
{{- define "cga-proxy.orchestrator.fullname" -}}
{{- printf "%s-orchestrator" (include "cga-proxy.fullname" .) -}}
{{- end }}

{{/*
Fullname suffixed with envoy
*/}}
{{- define "cga-proxy.envoy.fullname" -}}
{{- printf "%s-envoy" (include "cga-proxy.fullname" .) -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cga-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cga-proxy.labels" -}}
helm.sh/chart: {{ include "cga-proxy.chart" . }}
{{ include "cga-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Orchestrator labels
*/}}
{{- define "cga-proxy.orchestrator.labels" -}}
app.kubernetes.io/component: orchestrator
{{- end }}

{{/*
Envoy labels
*/}}
{{- define "cga-proxy.envoy.labels" -}}
app.kubernetes.io/component: envoy
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cga-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cga-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Orchestrator image
*/}}
{{- define "cga-proxy.orchestrator.imageConcat" -}}
{{- if .Values.orchestrator.image.sha256 }}
{{- printf "%s:%s@sha256:%s" .Values.orchestrator.image.repository .Values.orchestrator.image.tag .Values.orchestrator.image.sha256 -}}
{{- else }}
{{- printf "%s:%s" .Values.orchestrator.image.repository .Values.orchestrator.image.tag -}}
{{- end }}
{{- end }}

{{/*
Envoy image
*/}}
{{- define "cga-proxy.envoy.imageConcat" -}}
{{- if .Values.envoy.image.sha256 }}
{{- printf "%s:%s@sha256:%s" .Values.envoy.image.repository .Values.envoy.image.tag .Values.envoy.image.sha256 -}}
{{- else }}
{{- printf "%s:%s" .Values.envoy.image.repository .Values.envoy.image.tag -}}
{{- end }}
{{- end }}

{{/*
Orchestrator replicaCalc generator
*/}}
{{- define "cga-proxy.orchestrator.replicaCalc" -}}
{{- if .Values.orchestrator.highAvailability.enabled }}
{{- add .Values.orchestrator.replicaCount 1 -}}
{{- else }}
{{- .Values.orchestrator.replicaCount -}}
{{- end }}
{{- end }}
