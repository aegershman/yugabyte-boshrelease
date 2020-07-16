#!/usr/bin/env bash

set -eu

RM_POST_INSTALL_COMPLETED_ON_STARTUP=<%= p("rm_post_install_completed_on_startup") %>
if [ "${RM_POST_INSTALL_COMPLETED_ON_STARTUP}" = "true" ]; then
  echo "pre_start will be removing the following .post_install.sh.completed markers before re-initializing post_install.sh..."
  find -L /var/vcap/packages /var/vcap/data/packages -type f -name ".post_install.sh.completed" -print -delete
fi

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-tserver/bin/cert-linker.sh
