#!/usr/bin/env bash

set -eu

chown vcap:vcap -R /var/vcap/packages/yugabyte
su - vcap -c '/var/vcap/packages/yugabyte/bin/post_install.sh'
