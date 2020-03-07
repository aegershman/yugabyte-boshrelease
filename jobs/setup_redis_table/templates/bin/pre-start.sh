#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh

chmod +x /var/vcap/jobs/setup_redis_table/bin/yb-admin.sh
