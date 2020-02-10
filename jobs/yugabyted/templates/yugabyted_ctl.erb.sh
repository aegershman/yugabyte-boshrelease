#!/bin/bash

set -e -u

RUN_DIR=/var/vcap/sys/run/yugabyted
LOG_DIR=/var/vcap/sys/log/yugabyted
STORE_DIR=/var/vcap/store
DATA_DIR=${STORE_DIR}/yugabyted
PIDFILE=${RUN_DIR}/pid

mkdir -p ${RUN_DIR} ${LOG_DIR} ${DATA_DIR}
chown -R vcap:vcap ${RUN_DIR} ${LOG_DIR}

exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  echo $$ >${PIDFILE}
  exec /var/vcap/packages/yugabyte/bin/yugabyted start \
    --data_dir ${DATA_DIR} \
    --log_dir ${LOG_DIR} \
    --bind_ip <%= spec.address %>
  ;;

stop)
  exec /var/vcap/packages/yugabyte/bin/yugabyted stop
  kill -9 $(cat ${PIDFILE})
  rm -f ${PIDFILE}
  ;;

*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
