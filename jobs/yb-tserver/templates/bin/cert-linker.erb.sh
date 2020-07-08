#!/usr/bin/env bash

set -eu

ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.crt /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.crt
ln -sf /var/vcap/jobs/yb-tserver/config/certs/node.key /var/vcap/jobs/yb-tserver/config/certs/node.<%= spec.address %>.key
