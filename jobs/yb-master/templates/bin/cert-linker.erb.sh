#!/usr/bin/env bash

set -eu

# here we're creating a symbolic link between the
# files containing content of certificates and the files
# which yugabyte will look for due to their naming
#
# for example, given...
# /var/vcap/jobs/yb-master/config/certs/node.crt
#
# we would expect the end result to be a linked file named something like...
# /var/vcap/jobs/yb-master/config/certs/node.q-m90067n3s0.q-g88396.bosh.crt
#
# we assume this because of the following log line from /var/vcap/sys/log/yb-master/yb-master.INFO:
# tail yb-master.INFO
# ...
# I0305 00:19:30.295537     6 secure.cc:102] Certs directory: /var/vcap/jobs/yb-master/config/certs, name: q-m90323n3s0.q-g88658.bosh
# ...
#
# we assume that /var/vcap/jobs/yb-master/config/certs/ca.crt is already statically named
#
# example ls
# master/b62a2c62-4ba7-486a-baf1-8fb9672dc213:/var/vcap/jobs/yb-master/config/certs# ls -la
# total 20
# drwxr-x--- 2 root vcap 4096 Mar  3 20:23 .
# drwxr-x--- 3 root vcap 4096 Mar  3 20:23 ..
# -rw-r----- 1 root vcap 1110 Mar  3 20:23 ca.crt
# -rw-r----- 1 root vcap 1122 Mar  3 20:23 node.crt
# -rw-r----- 1 root vcap 1678 Mar  3 20:23 node.key
# lrwxrwxrwx 1 root root   46 Mar  3 20:23 node.q-m90067n3s0.q-g88396.bosh.crt -> /var/vcap/jobs/yb-master/config/certs/node.crt
# lrwxrwxrwx 1 root root   46 Mar  3 20:23 node.q-m90067n3s0.q-g88396.bosh.key -> /var/vcap/jobs/yb-master/config/certs/node.key
#
chmod 0600 /var/vcap/jobs/yb-master/config/certs/node.key
ln -sf /var/vcap/jobs/yb-master/config/certs/node.crt /var/vcap/jobs/yb-master/config/certs/node.<%= spec.address %>.crt
ln -sf /var/vcap/jobs/yb-master/config/certs/node.key /var/vcap/jobs/yb-master/config/certs/node.<%= spec.address %>.key
