#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-tserver/bin/cert-linker.sh
if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  /var/vcap/jobs/yb-tserver/bin/yb-init-pg.sh
else
  echo "pre_start will not be performing a manual ysql init"
fi
