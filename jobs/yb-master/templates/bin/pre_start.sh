#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh
if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  /var/vcap/jobs/yb-master/bin/yb-init-pg.sh
fi
