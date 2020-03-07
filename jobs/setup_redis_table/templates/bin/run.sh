#!/usr/bin/env bash

set -eu

/var/vcap/jobs/bpm/bin/bpm run setup_redis_table -p setup_redis_table
