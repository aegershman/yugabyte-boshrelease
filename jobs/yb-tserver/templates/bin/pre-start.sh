#!/usr/bin/env bash

set -eu

/var/vcap/packages/yugabyte/bin/post_install.sh

update-locale LC_ALL="en_US.utf8" LANG="en_US.utf8"
