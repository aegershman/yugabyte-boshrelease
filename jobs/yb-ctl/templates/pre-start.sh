#!/bin/bash

set -e -u

echo "performing yugabyte/bin/post_install.sh in pre-start.sh"
/var/vcap/packages/yugabyte/bin/post_install.sh
