#!/usr/bin/env bash

set -eux

sed '/^distribution_dir=$(cd "$bin_dir/.." && pwd)/a if [[ -L $distribution_dir ]]; then; distribution_dir=$( realpath "$distribution_dir" ); fi' post-install.sh
