{{/* vim: set syntax=helm: */}}

{{/*
Define the pod spec
*/}}
{{- define "msmtp.jobSpec" -}}

backoffLimit: 1
completions: 1
parallelism: 1
template:
  metadata:
    {{- with .Values.podAnnotations }}
    annotations:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    labels:
      {{- include "msmtp.selectorLabels" . | nindent 6 }}
  spec:
    restartPolicy: Never
    {{- with .Values.imagePullSecrets }}
    imagePullSecrets:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    serviceAccountName: {{ include "msmtp.serviceAccountName" . }}
    securityContext:
      {{- toYaml .Values.podSecurityContext | nindent 6 }}
    volumes:
    - name: temp
      emptyDir: {}
    - name: mailer-config
      configMap:
        defaultMode: 0640
        name: {{ printf "%s-config" (include "msmtp.fullname" .) }}
    - name: smtp-secret
      secret:
        defaultMode: 0640
        secretName: {{ .Values.smtp.secretName }}
    {{- if .Values.email.attachments }}
    - name: attachments
      persistentVolumeClaim:
        claimName: {{ .Values.email.attachments.pvcName }}
    {{- end }}{{/* if .Values.email.attachments */}}
    containers:
    - name: send-email
      image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8 }}
      command: 
      - bash
      - -xue
      args:
      - -c
      - |-
        {{- (.Files.Get "files/send-email.sh") | nindent 10 }}
      env:
      - name: TO_EMAIL
        value: {{ .Values.email.to }}
      - name: EMAIL_SUBJECT
        {{- if .Values.email.subject }}
        value: {{ .Values.email.subject | quote }}
        {{- else }}
        valueFrom:
          configMapKeyRef:
            name: {{ .Values.email.subjectFrom.configmapName }}
            key: {{ .Values.email.subjectFrom.key }}
        {{- end }}{{/* .Values.email.subject */}}
      - name: EMAIL_BODY
        {{- if .Values.email.body }}
        value: {{ .Values.email.body | quote }}
        {{- else }}
        valueFrom:
          configMapKeyRef:
            name: {{ .Values.email.bodyFrom.configmapName }}
            key: {{ .Values.email.bodyFrom.key }}
        {{- end }}{{/* .Values.email.body */}}
      {{- if .Values.email.attachments }}
      {{- range $index, $attachment := .Values.email.attachments.files }}
      - name: {{ printf "EMAIL_ATTACHMENTS_%d_NAME" $index }}
        value: {{ $attachment.name | quote}}
      - name: {{ printf "EMAIL_ATTACHMENTS_%d_PATH" $index }}
        value: {{ $attachment.path | quote }}
      {{- end }}{{/* range .Values.email.attachments.files */}}
      {{- end }}{{/* if .Values.email.attachments */}}
      volumeMounts:
      - name: mailer-config
        mountPath: /home/user1/.muttrc
        subPath: .muttrc
        readOnly: true
      - name: mailer-config
        mountPath: /home/user1/.msmtprc
        subPath: .msmtprc
        readOnly: true
      - name: smtp-secret
        mountPath: /secrets/smtp
        readOnly: true
      {{- if .Values.email.attachments }}
      - name: attachments
        mountPath: /home/user1/attachments
        {{- with .Values.email.attachments.subPath }}
        subPath: {{ . }}
        {{- end }}{{/* with .Values.email.attachments.subPath */}}
        readOnly: true
      {{- end }}{{/* if .Values.email.attachments */}}
      resources: {{- toYaml .Values.resources | nindent 8 }}
    {{- with .Values.nodeSelector }}
    nodeSelector:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .Values.affinity }}
    affinity:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .Values.tolerations }}
    tolerations:
      {{- toYaml . | nindent 6 }}
    {{- end }}

{{- end }}{{/* define */}}
