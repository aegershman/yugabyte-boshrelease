#!/usr/bin/env bash

set -eu

# TODO still necessary?
chown -R vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot

if [ "${RM_POST_INSTALL_COMPLETED_ON_STARTUP}" = "true" ]; then
  echo "pre_start will be removing the following .post_install.sh.completed markers before re-initializing post_install.sh..."
  find -L /var/vcap/packages /var/vcap/data/packages -type f -name ".post_install.sh.completed" -print -delete
fi

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh

if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  echo "pre_start is now performing a manual initdb for ysql"
  YB_ENABLED_IN_POSTGRES=1
  FLAGS_pggate_master_addresses=<%= link("yb-master").instances.map { |i| "#{i.address}:#{p('rpc_bind_addresses_port')}" }.join(",") %>
  su - vcap -c '/var/vcap/packages/yugabyte/postgres/bin/initdb -D /var/vcap/data/yb-master/tmp/pg_data_tmp -U postgres'
fi
