#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/yb-ctl stop
/var/vcap/packages/yugabyte/bin/yb-ctl status
