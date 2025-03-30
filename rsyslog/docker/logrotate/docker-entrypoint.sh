#!/bin/sh
set -ue

crontabFile=$(mktemp -p/tmp crontab.XXXXXX)
logrotateStateFile=$(mktemp -p/tmp logrotate.XXXXXX)

echo "${CRON_SCHEDULE} logrotate -v -s ${logrotateStateFile} /etc/logrotate.conf" | tee ${crontabFile} 
exec supercronic ${crontabFile}
