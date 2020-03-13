#!/usr/bin/env bash

set -eu

ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.crt /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.crt
ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.key /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.key

if [ ! -f "/var/vcap/store/yb-tserver/pg_data/postgresql.conf" ]; then
  # initdb creates data directories
  su - vcap -c "/var/vcap/packages/yugabyte/postgres/bin/initdb --no-locale -D /var/vcap/store/yb-tserver/pg_data/ -U postgres"
else
  echo "appears /var/vcap/store/yb-tserver/pg_data/postgresql.conf exists and has been initialized"
fi
