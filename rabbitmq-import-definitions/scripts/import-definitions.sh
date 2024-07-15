#!/bin/sh
set -ue

set -x

# create vhost (idempotent)
curl -s -i -XPUT ${RABBITMQ_MANAGEMENT_URL}/api/vhosts/%2F${RABBITMQ_VHOST} -H "content-type:application/json" -d '{}'

# import definitions for vhost
curl -s -i -XPOST ${RABBITMQ_MANAGEMENT_URL}/api/definitions/%2F${RABBITMQ_VHOST} -H "content-type:application/json" -d @definitions.json

# show definitions
curl -s -i -XGET ${RABBITMQ_MANAGEMENT_URL}/api/definitions/%2F${RABBITMQ_VHOST}
