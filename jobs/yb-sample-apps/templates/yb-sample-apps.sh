#!/bin/bash

set -e

export PATH=${JAVA_HOME}/bin:${PATH}

case "$1" in
*)
  java \
    -Xmx${MAX_HEAP_SIZE}m \
    -Djava.security.egd=file:/dev/urandom \
    -jar /var/vcap/packages/yb-sample-apps/yb-sample-apps.jar \
    --workload ${WORKLOAD_TYPE} \
    --nodes ${TSERVER_ENDPOINTS} \
    $@
  ;;
esac
