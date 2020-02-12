#!/bin/bash

set -eux

/var/vcap/jobs/bpm/bin/bpm run yb-admin -p yb-admin
