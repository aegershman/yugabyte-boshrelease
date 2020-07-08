#!/usr/bin/env bash

set -eu

echo "running post-deploy..."

source /var/vcap/packages/python*/bosh/runtime.env

echo "running post-deploy ycql rotate admin password check..."
/var/vcap/jobs/yb-tserver/bin/ycql-rotate-default-admin-password.sh

echo "running post-deploy ycqlsh setup..."
/var/vcap/packages/yugabyte/bin/ycqlsh \
  --cqlshrc /var/vcap/jobs/yb-tserver/config/cqlshrc \
  --file /var/vcap/jobs/yb-tserver/config/roles.cql \
  --debug

echo "running post-deploy for ysqlsh setup..."
PGDATABASE=yugabyte
PGHOST=<%= spec.address %>
PGPASSWORD=yugabyte
PGPORT=<%= p("pgsql_proxy_bind_port") %>
PGSSLCERT='/var/vcap/jobs/yb-tserver/config/certs/node.crt'
PGSSLKEY='/var/vcap/jobs/yb-tserver/config/certs/node.key'
PGSSLMODE='prefer'
PGSSLROOTCERT='/var/vcap/jobs/yb-tserver/config/certs/ca.crt'
PGUSER=yugabyte
/var/vcap/packages/yugabyte/bin/ysqlsh \
  --echo-all \
  --no-psqlrc \
  --file=/var/vcap/jobs/yb-tserver/config/roles.sql

echo "post-deploy run complete..."
