#!/usr/bin/env bash

set -eu

# cd /var/vcap/data/packages/yugabyte/2a0089f71899ee62de9d4b69e69af783745c0881
# # cd /var/vcap/data/packages/yugabyte/*
# rm -f ".post_install.sh.completed"
# ./bin/post_install.sh

cd /var/vcap/packages/yugabyte
rm -f ".post_install.sh.completed"
./bin/post_install.sh
