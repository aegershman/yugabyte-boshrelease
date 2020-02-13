#!/usr/bin/env bash

set -eu

/var/vcap/jobs/bpm/bin/bpm run yb-admin -p yb-admin
