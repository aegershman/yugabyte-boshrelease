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

<% if !p("enable_ysql") %>
echo "skipping any of the ysql work for the moment since enable_ysql is false..."
exit 0
echo "post-deploy run complete..."
<% end %>

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
  --set=ON_ERROR_STOP=1 \
  --file=/var/vcap/jobs/yb-tserver/config/roles.sql

echo "post-deploy run complete..."
