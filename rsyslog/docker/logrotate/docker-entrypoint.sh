#!/bin/sh
set -ue

crontabFile=$(mktemp -p/tmp crontab.XXXXXX)
logrotateArgs="--verbose --state=/var/lib/logrotate/logrotate.status /etc/logrotate.conf"

echo "${CRON_SCHEDULE} logrotate ${logrotateArgs}" | tee ${crontabFile} 
exec supercronic ${crontabFile}
