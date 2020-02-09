#!/bin/bash

set -e -u

/var/vcap/packages/yugabyte/bin/yugabyted stop --config=/var/vcap/jobs/yugabyted/yugabyted.conf
