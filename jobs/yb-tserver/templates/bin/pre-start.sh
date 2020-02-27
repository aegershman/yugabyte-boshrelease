#!/usr/bin/env bash

set -eux

cd /var/vcap/data/packages/yugabyte/2a0089f71899ee62de9d4b69e69af783745c0881
./bin/post_install.sh
