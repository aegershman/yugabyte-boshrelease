#!/usr/bin/env bash

set -eu

export PATH=${JAVA_HOME}/bin:${PATH}

java \
  -Xmx${MAX_HEAP_SIZE}m \
  -Djava.security.egd=file:/dev/urandom \
  -jar /var/vcap/packages/yb-sample-apps/yb-sample-apps.jar \
  --workload ${WORKLOAD_TYPE} \
  --nodes ${TSERVER_ENDPOINTS} \
  $@

# TODO should we exit failure here if this finishes to force a failure/restart?
exit 1
