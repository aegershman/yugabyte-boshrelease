#!/usr/bin/env bash

set -eu

chown -R vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot

<% if p("rm_post_install_completed_on_startup") %>
echo "pre_start will be removing the following .post_install.sh.completed markers before re-initializing post_install.sh..."
find -L /var/vcap/packages /var/vcap/data/packages -type f -name ".post_install.sh.completed" -print -delete
<% end %>

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh
