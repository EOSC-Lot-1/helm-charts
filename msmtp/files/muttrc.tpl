set sendmail = "/usr/bin/msmtp"
set use_from = yes
set from = {{ $.from | default "someone@example.com" | quote }}

set edit_headers=no
set editor = "true"
set confirmappend = no
set delete = yes
set move = no
set quit = yes
