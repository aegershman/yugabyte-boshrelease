#!/usr/bin/env bash

set -eu

rm -f /var/vcap/packages/yugabyte/.post_install.sh.completed
/var/vcap/packages/yugabyte/bin/post_install.sh
# chown -R root:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot
# chmod 700 /var/vcap/packages/yugabyte/share/

chown vcap:vcap -R /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b
chown vcap:vcap -R /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b
chown vcap:vcap -R /var/vcap/packages/yugabyte
chown vcap:vcap -R /var/vcap/packages/yugabyte/share
chown vcap:vcap /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b/share/initial_sys_catalog_snapshot/exported_tablet_metadata_changes
chown vcap:vcap /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot

# echo "just finished chown, listing directories:"
# ls -laR /var/vcap/packages/yugabyte/share
# ls -laR /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b
# ls -la /var/vcap/packages/yugabyte/share/initial_sys_catalog_snapshot
# ls -la /var/vcap/data/packages/yugabyte/db77bbcc0b1b255adcfdda76698a1a7051e6b43b/share/initial_sys_catalog_snapshot/exported_tablet_metadata_changes
