{{/* vim: set syntax=helm: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "thanos.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "thanos.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "thanos.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "thanos.labels" -}}
helm.sh/chart: {{ include "thanos.chart" . }}
{{ include "thanos.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "thanos.labelsForReceiver" -}}
{{ include "thanos.labels" . }}
app.kubernetes.io/component: receiver
{{- end }}

{{- define "thanos.labelsForQuerier" -}}
{{ include "thanos.labels" . }}
app.kubernetes.io/component: querier
{{- end }}

{{- define "thanos.labelsForStore" -}}
{{ include "thanos.labels" . }}
app.kubernetes.io/component: store
{{- end }}

{{- define "thanos.labelsForCompactor" -}}
{{ include "thanos.labels" . }}
app.kubernetes.io/component: compactor
{{- end }}

{{- define "thanos.selectorLabels" -}}
app.kubernetes.io/name: {{ include "thanos.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "thanos.selectorLabelsForReceiver" -}}
{{ include "thanos.selectorLabels" . }}
app.kubernetes.io/component: receiver
{{- end }}

{{- define "thanos.selectorLabelsForQuerier" -}}
{{ include "thanos.selectorLabels" . }}
app.kubernetes.io/component: querier
{{- end }}

{{- define "thanos.selectorLabelsForStore" -}}
{{ include "thanos.selectorLabels" . }}
app.kubernetes.io/component: store
{{- end }}

{{- define "thanos.selectorLabelsForCompactor" -}}
{{ include "thanos.selectorLabels" . }}
app.kubernetes.io/component: compactor
{{- end }}

{{- define "thanos.serviceNameForReceiver" -}}
{{ printf "%s-receiver" (include "thanos.fullname" .) }}
{{- end }}

{{- define "thanos.serviceNameForQuerier" -}}
{{ printf "%s-querier" (include "thanos.fullname" .) }}
{{- end }}

{{- define "thanos.serviceNameForStore" -}}
{{ printf "%s-store" (include "thanos.fullname" .) }}
{{- end }}

{{- define "thanos.serviceFqdnForReceiver" -}}
{{ printf "%s.%s.svc.cluster.local" (include "thanos.serviceNameForReceiver" .) .Release.Namespace }}
{{- end }}

{{- define "thanos.serviceFqdnForStore" -}}
{{ printf "%s.%s.svc.cluster.local" (include "thanos.serviceNameForStore" .) .Release.Namespace }}
{{- end }}

{{- define "thanos.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "thanos.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "thanos.objstoreSecretName" -}}
{{ .Values.objstore.secretName | default (printf "%s-bucket-config" (include "thanos.fullname" .)) }}
{{- end }}

{{- define "thanos.livenessProbe" -}}
httpGet:
  path: /-/healthy
  port: http 
initialDelaySeconds: 20
periodSeconds: 30
{{- end }}

{{- define "thanos.readinessProbe" -}}
httpGet:
  path: /-/ready
  port: http 
initialDelaySeconds: 20
periodSeconds: 30
{{- end }}

