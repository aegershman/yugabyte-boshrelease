#!/bin/bash

set -eu

RUN_DIR=/var/vcap/sys/run/yb-master
LOG_DIR=/var/vcap/sys/log/yb-master
DATA_DIR=/var/vcap/store/yb-master
PIDFILE=${RUN_DIR}/pid

mkdir -p ${RUN_DIR} ${LOG_DIR} ${DATA_DIR}
exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  echo $$ >${PIDFILE}

  exec yb-master \
    --fs_data_dirs=${DATA_DIR} \
    --rpc_bind_addresses={{ '<%= spec.address %>' }} \
    --server_broadcast_addresses={{ '<%= spec.address %>' }}:7100 \
    --master_addresses=--{{ 'link("yb-master").instances.map { |instance| "#{instance.address}" }.join(",")' }} \
    --replication_factor={{ 'link("yb-master").instances.length' }} \
    --enable_ysql={{ '<%= p("enable_ysql") %>' }} \
    --stderrthreshold={{ '<%= p("stderrthreshold") %>' }} \
    --log_dir=${LOG_DIR}
  ;;

stop)
  kill -9 $(cat ${PIDFILE})
  rm -f ${PIDFILE}
  ;;

*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
