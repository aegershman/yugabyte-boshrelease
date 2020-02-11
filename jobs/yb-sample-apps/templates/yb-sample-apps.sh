#!/bin/bash

set -e -u -o pipefail

cd /var/vcap/packages/yb-sample-apps

export PATH=${JAVA_HOME}/bin:${PATH}

java -Xmx${MAX_HEAP_SIZE}m -Djava.security.egd=file:/dev/urandom \
  -jar *.jar \
  --workload CassandraKeyValue \
  --nodes ${YCQL_ENDPOINTS} \
  --nouuid \
  --value_size 256 \
  --num_threads_read 0 \
  --num_threads_write 256 \
  --num_unique_keys 1000000000
