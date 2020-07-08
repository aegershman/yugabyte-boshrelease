#!/usr/bin/env bash

set -eu

chmod 0600 /var/vcap/jobs/yb-tserver/config/certs/node.key
ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.crt /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.crt
ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.key /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.key
