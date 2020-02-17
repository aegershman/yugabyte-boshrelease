#!/usr/bin/env bash

set -eu

source /var/vcap/packages/python-*/bosh/runtime.env

/var/vcap/packages/yugabyte/bin/cqlsh \
  --debug \
  --cqlshrc /var/vcap/jobs/yb-tserver/config/cqlshrc \
  --file /var/vcap/jobs/yb-tserver/config/ycql.roles.cql
