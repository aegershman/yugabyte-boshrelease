#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh

chmod +x /var/vcap/jobs/yb-admin/bin/yb-admin.sh
