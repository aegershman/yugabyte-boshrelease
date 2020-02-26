#!/usr/bin/env bash

set -eu

source /var/vcap/packages/python-*/bosh/runtime.env

# TEMP
# echo "running post-deploy..."
# /var/vcap/packages/yugabyte/bin/cqlsh \
#   --cqlshrc /var/vcap/jobs/yb-tserver/config/cqlshrc \
#   --file /var/vcap/jobs/yb-tserver/config/roles.cql \
#   --debug
