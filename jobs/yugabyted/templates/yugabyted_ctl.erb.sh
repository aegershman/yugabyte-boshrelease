#!/bin/bash

set -e -u -x

RUN_DIR=/var/vcap/sys/run/yugabyted
LOG_DIR=/var/vcap/sys/log/yugabyted
STORE_DIR=/var/vcap/store
CONFIG_DIR=${STORE_DIR}/yugabyted
PIDFILE=${RUN_DIR}/yugabyted.pid

mkdir -p ${RUN_DIR} ${LOG_DIR} ${CONFIG_DIR} ${DATA_DIR}
chown -R vcap:vcap ${RUN_DIR} ${LOG_DIR}

exec 1>> "${LOG_DIR}/yugabyted_ctl.stdout.log"
exec 2>> "${LOG_DIR}/yugabyted_ctl.stderr.log"

case $1 in
start)
  echo $$>${PIDFILE}
  /var/vcap/packages/yugabyte/bin/yugabyted start \
    --data_dir ${CONFIG_DIR} \
    --log_dir ${LOG_DIR} \
    --bind_ip <%= spec.address %>
  ;;

stop)
  /var/vcap/packages/yugabyte/bin/yugabyted stop
  kill -9 $( cat ${PIDFILE})
  rm -f ${PIDFILE}
  ;;

*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
