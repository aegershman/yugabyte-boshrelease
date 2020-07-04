#!/usr/bin/env bash

set -eu

# TODO still necessary?
chown -R vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot

if [ "${RM_POST_INSTALL_COMPLETED_ON_STARTUP}" = "true" ]; then
  echo "pre_start will be removing the .post_install.sh.completed marker before re-initializing post_install.sh"
  find -L /var/vcap/packages /var/vcap/data/packages -type f -name ".post_install.sh.completed" -delete
fi

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh
