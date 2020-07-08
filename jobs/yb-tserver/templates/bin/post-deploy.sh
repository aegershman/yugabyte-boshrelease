#!/usr/bin/env bash

set -eu

echo "running post-deploy..."

ENABLE_MANUAL_YSQL_INIT=<%= p("enable_manual_ysql_init") %>
if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  echo "now evaluating a manual initdb for ysql..."
  YB_ENABLED_IN_POSTGRES=1
  FLAGS_pggate_master_addresses=<%= link("yb-master").instances.map { |i| "#{i.address}:#{p('rpc_bind_addresses_port')}" }.join(",") %>
  if [ ! -d "/var/vcap/data/yb-tserver/tmp/pg_data_tmp" ]; then
    echo "/var/vcap/data/yb-tserver/tmp/pg_data_tmp does not appear to exist, now manually initializing with initdb..."
    su - vcap -c '/var/vcap/packages/yugabyte/postgres/bin/initdb -D /var/vcap/data/yb-tserver/tmp/pg_data_tmp -U postgres'
  else
    echo "/var/vcap/data/yb-tserver/tmp/pg_data_tmp appears to already exist, not removing anything..."
    echo "WARNING: THIS MEANS YOU SHOULD PROBABLY REMOVE ANY UPGRADE OPSFILES"
  fi
fi

source /var/vcap/packages/python*/bosh/runtime.env

echo "running post-deploy ycql rotate admin password check..."
/var/vcap/jobs/yb-tserver/bin/ycql-rotate-default-admin-password.sh

echo "running post-deploy ycqlsh setup..."
/var/vcap/packages/yugabyte/bin/ycqlsh \
  --cqlshrc /var/vcap/jobs/yb-tserver/config/cqlshrc \
  --file /var/vcap/jobs/yb-tserver/config/roles.cql \
  --debug

echo "running post-deploy for ysqlsh setup..."
export PGDATABASE=yugabyte
export PGHOST=<%= spec.address %>
export PGPASSWORD=yugabyte
export PGPORT=<%= p("pgsql_proxy_bind_port") %>
export PGSSLCERT='/var/vcap/jobs/yb-tserver/config/certs/node.crt'
export PGSSLKEY='/var/vcap/jobs/yb-tserver/config/certs/node.key'
export PGSSLMODE='prefer'
export PGSSLROOTCERT='/var/vcap/jobs/yb-tserver/config/certs/ca.crt'
export PGUSER=yugabyte
/var/vcap/packages/yugabyte/bin/ysqlsh \
  --no-psqlrc \
  --set=ON_ERROR_STOP=1 \
  --single-transaction \
  --file=/var/vcap/jobs/yb-tserver/config/roles.sql

echo "post-deploy run complete..."
