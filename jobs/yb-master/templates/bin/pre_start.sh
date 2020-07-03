#!/usr/bin/env bash

set -eu

# TODO still necessary?
chown -R vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-master/bin/cert-linker.sh
