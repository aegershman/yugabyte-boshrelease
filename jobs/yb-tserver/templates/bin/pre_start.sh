#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh
/var/vcap/jobs/yb-tserver/bin/cert-linker.sh
/var/vcap/jobs/yb-tserver/bin/yb-init-pg.sh
