#!/usr/bin/env bash

set -eu

# /var/vcap/packages/yugabyte/bin/post_install.sh
# # # cd /var/vcap/data/packages/yugabyte/*
# cd /var/vcap/data/packages/yugabyte/2a0089f71899ee62de9d4b69e69af783745c0881
# echo "initial ls"
# ls -la
# echo "attempting rm"
# rm -f ".post_install.sh.completed"
# ls -la
# ./bin/post_install.sh
# echo "post-install ls"
# ls -la

cd /var/vcap/data/packages/yugabyte/2a0089f71899ee62de9d4b69e69af783745c0881
rm -f ".post_install.sh.completed"
./bin/post_install.sh
