#!/usr/bin/env bash

set -eu

if [ ! -f "/var/vcap/store/yb-tserver/pg_data/postgresql.conf" ]; then
  # initdb creates data directories
  su - vcap -c "/var/vcap/packages/yugabyte/postgres/bin/initdb /var/vcap/store/yb-tserver/pg_data -U postgres"
else
  echo "appears /var/vcap/store/yb-tserver/pg_data/postgresql.conf exists and has been initialized"
fi
