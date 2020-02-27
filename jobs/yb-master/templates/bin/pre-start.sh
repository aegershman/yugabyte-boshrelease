#!/usr/bin/env bash

set -eu

rm -f /var/vcap/packages/yugabyte/.post_install.sh.completed
/var/vcap/packages/yugabyte/bin/post_install.sh

chown vcap:vcap -R /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b
chown vcap:vcap -R /var/vcap/packages/yugabyte
