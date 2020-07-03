#!/usr/bin/env bash

set -eu

chown -R vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot
if [ ! -f "/var/vcap/store/yb-master/pg_data/postgresql.conf" ]; then
  # initdb creates data directories
  # su - vcap -c 'LC_ALL=C /var/vcap/packages/yugabyte/postgres/bin/initdb -D /var/vcap/store/yb-master/pg_data -U postgres'
  :
else
  echo "appears /var/vcap/store/yb-master/pg_data/postgresql.conf exists and has been initialized"
fi
