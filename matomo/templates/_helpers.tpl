{{/*
Return the full name of the chart
*/}}
{{- define "matomo.fullname" -}}
{{- printf "%s" .Release.Name -}}
{{- end -}}

