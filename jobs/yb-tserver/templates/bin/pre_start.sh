#!/usr/bin/env bash

set -eu

RM_POST_INSTALL_COMPLETED_ON_STARTUP=true
if [ "${RM_POST_INSTALL_COMPLETED_ON_STARTUP}" = "true" ]; then
  find -L /var/vcap/packages /var/vcap/data/packages -type f -name ".post_install.sh.completed" -delete
fi

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-tserver/bin/cert-linker.sh
