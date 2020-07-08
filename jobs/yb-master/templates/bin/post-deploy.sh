#!/usr/bin/env bash

set -eu

echo "running post-deploy..."

ENABLE_MANUAL_YSQL_INIT=<%= p("enable_manual_ysql_init") %>
if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  echo "now evaluating a manual initdb for ysql..."
  YB_ENABLED_IN_POSTGRES=1
  FLAGS_pggate_master_addresses=<%= link("yb-master").instances.map { |i| "#{i.address}:#{p('rpc_bind_addresses_port')}" }.join(",") %>
  if [ ! -d "/var/vcap/data/yb-master/tmp/pg_data_tmp" ]; then
    echo "/var/vcap/data/yb-master/tmp/pg_data_tmp does not appear to exist, now manually initializing with initdb..."
    su - vcap -c '/var/vcap/packages/yugabyte/postgres/bin/initdb -D /var/vcap/data/yb-master/tmp/pg_data_tmp -U postgres'
  else
    echo "/var/vcap/data/yb-master/tmp/pg_data_tmp appears to already exist, not removing anything..."
    echo "WARNING: THIS MEANS YOU SHOULD PROBABLY REMOVE ANY UPGRADE OPSFILES"
  fi
fi