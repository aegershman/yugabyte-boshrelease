#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh
if [ "${ENABLE_MANUAL_YSQL_INIT}" = "true" ]; then
  echo "pre_start is now performing a manual initdb for ysql"
  /var/vcap/jobs/yb-master/bin/yb-init-pg.sh
else
  echo "pre_start will not be performing a manual initdb for ysql"
fi
