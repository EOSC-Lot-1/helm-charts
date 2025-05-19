defaults
auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host {{ $.server | default "smtp.example.com" }}
port {{ $.port | default "587" | int }}
from {{ $.from | default "someone@example.com" }}
user {{ $.user | default "someone@example.com" }}
passwordeval "cat /secrets/smtp/password"
