#!/usr/bin/env bash

set -eu

source /var/vcap/packages/python*/bosh/runtime.env

echo "running post-deploy..."

/var/vcap/jobs/yb-tserver/bin/ycql-rotate-default-admin-password.sh

/var/vcap/packages/yugabyte/bin/ycqlsh \
  --cqlshrc /var/vcap/jobs/yb-tserver/config/cqlshrc \
  --file /var/vcap/jobs/yb-tserver/config/roles.cql \
  --debug

PSQLRC=/var/vcap/jobs/yb-tserver/config/psqlrc
PGPASSFILE=/var/vcap/jobs/yb-tserver/config/pgpass
/var/vcap/packages/yugabyte/bin/ysqlsh \
  --list
  # --file=/var/vcap/jobs/yb-tserver/config/roles.sql
