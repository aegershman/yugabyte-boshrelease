#!/usr/bin/env bash

set -eu

# https://docs.yugabyte.com/v1.2/deploy/manual-deployment/system-config/#setting-system-wide-ulimits
ulimit -l unlimited
ulimit -a
/var/vcap/packages/yugabyte/bin/post_install.sh
