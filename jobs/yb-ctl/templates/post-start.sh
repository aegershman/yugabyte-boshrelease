#!/bin/bash

set -e -u

/var/vcap/packages/yugabyte/bin/yb-ctl setup_redis
/var/vcap/packages/yugabyte/bin/yb-ctl status
