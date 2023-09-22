{{- define "envvars" }}
env:
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v }}
{{- end }}
{{- end }}
