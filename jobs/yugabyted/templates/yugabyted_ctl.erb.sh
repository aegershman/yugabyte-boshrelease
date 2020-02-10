#!/bin/bash

set -e -u

RUN_DIR=/var/vcap/sys/run/yugabyted
LOG_DIR=/var/vcap/sys/log/yugabyted
STORE_DIR=/var/vcap/store
CONFIG_DIR=${STORE_DIR}/yugabyted
PIDFILE=${RUN_DIR}/yugabyted.pid

mkdir -p ${RUN_DIR} ${LOG_DIR} ${CONFIG_DIR} ${DATA_DIR}
chown -R vcap:vcap ${RUN_DIR} ${LOG_DIR}

export PIDNUM=$$
exec > >(tee -a >(logger -p user.info -t vcap.$(basename $0).stdout) | awk -W interactive '{ system("echo -n [$(date +\"%Y-%m-%d %H:%M:%S%z\")] $PIDNUM"); print " " $0 }' >> ${LOG_DIR}/$(basename $0).log)
exec 2> >(tee -a >(logger -p user.error -t vcap.$(basename $0).stderr) | awk -W interactive '{ system("echo -n [$(date +\"%Y-%m-%d %H:%M:%S%z\")] $PIDNUM"); print " " $0 }' >> ${LOG_DIR}/$(basename $0).err.log)

case $1 in
start)
  echo ${PIDNUM} >${PIDFILE}
  exec /var/vcap/packages/yugabyte/bin/yugabyted start \
    --data_dir ${CONFIG_DIR} \
    --log_dir ${LOG_DIR} \
    --bind_ip <%= spec.address %>
  ;;

stop)
  exec /var/vcap/packages/yugabyte/bin/yugabyted stop
  kill -9 ${PIDNUM}
  rm -f ${PIDFILE}
  ;;

*)
  echo "Usage: ${0} {start|stop|status}"
  exit 1
  ;;
esac
