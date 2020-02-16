#!/usr/bin/env bash

set -eu

source /var/vcap/packages/python-*/bosh/runtime.env

# as you might expect, TODO
/var/vcap/packages/yugabyte/bin/cqlsh \
  --user cassandra \
  --password cassandra \
  --debug \
  --file /var/vcap/jobs/yb-tserver/config/superusers.cql \
  "<%= spec.address %>"
