#!/usr/bin/env bash

set -eu

ulimit -l unlimited
ulimit -a
sysctl -w fs.file-max=1048576

/var/vcap/packages/yugabyte/bin/post_install.sh
