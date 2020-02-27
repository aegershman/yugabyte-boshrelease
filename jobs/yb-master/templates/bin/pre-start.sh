#!/usr/bin/env bash

set -eu

cd /var/vcap/packages/yugabyte
rm -f ".post_install.sh.completed"
./bin/post_install.sh
