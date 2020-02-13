#!/usr/bin/env bash

set -eu

: ${AWS_ACCESS_KEY:?}
: ${AWS_SECRET_KEY:?}

###############################################################

cat >config/private.yml <<EOF
---
blobstore:
  provider: s3
  options:
    access_key_id: ${AWS_ACCESS_KEY}
    secret_access_key: ${AWS_SECRET_KEY}
EOF

RELEASE_NAME=$(bosh int config/final.yml --path /name)
bosh create-release --final --version "${VERSION}"
bosh create-release releases/${RELEASE_NAME}/${RELEASE_NAME}-${VERSION}.yml \
  --tarball releases/${RELEASE_NAME}/${RELEASE_NAME}-${VERSION}.tgz

###############################################################
