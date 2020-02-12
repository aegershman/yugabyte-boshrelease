#!/bin/bash

set -e -u

/var/vcap/packages/yugabyte/bin/post_install.sh

chmod +x /var/vcap/jobs/yb-admin/yb-admin.sh
