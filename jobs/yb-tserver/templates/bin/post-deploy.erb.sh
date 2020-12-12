#!/usr/bin/env bash

set -eu

echo "$(date --rfc-3339=seconds) entering post-deploy..."

source /var/vcap/packages/python*/bosh/runtime.env

INDEX=<%= spec.index %>
POST_DEPLOY_DELAY_FACTOR=<%= p('post_deploy_delay_factor') %>
POST_DEPLOY_DELAY_SECONDS=$(expr ${POST_DEPLOY_DELAY_FACTOR} \* ${INDEX})

echo "$(date --rfc-3339=seconds) post-deploy on node index ${INDEX} sleeping for ${POST_DEPLOY_DELAY_SECONDS} seconds before beginning post-deploy..."
sleep "${POST_DEPLOY_DELAY_SECONDS}"
echo "$(date --rfc-3339=seconds) post-deploy delay complete, running..."

####################################

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
  --set=ON_ERROR_STOP=1 \
  --file=/var/vcap/jobs/yb-tserver/config/roles.sql

echo "post-deploy run complete..."
