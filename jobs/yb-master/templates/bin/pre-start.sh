#!/usr/bin/env bash

set -eu

ulimit -l unlimited
/var/vcap/packages/yugabyte/bin/post_install.sh
