#!/usr/bin/env bash

set -eu

cd /var/vcap/packages/yugabyte/
./bin/post_install.sh
