#!/usr/bin/env bash

set -eu

source /var/vcap/packages/python-pkg/bosh/runtime.env

# as you might expect, TODO
/var/vcap/packages/yugabyte/bin/cqlsh \
  --user cassandra \
  --password cassandra \
  --debug \
  --file /var/vcap/jobs/yb-tserver/config/roles.cql \
  "<%= spec.address %>"
