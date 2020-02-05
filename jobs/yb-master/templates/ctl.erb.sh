#!/bin/bash

set -eu

LOG_DIR=/var/vcap/sys/log/yb-master
mkdir -p $LOG_DIR
exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  exec yb-master \
    --fs_data_dirs=${todo} \
    --rpc_bind_addresses=${spec_address} \
    --server_broadcast_addresses=${spec_address}:7100 \
    --master_addresses=${link} \
    --replication_factor=${link} \
    --enable_ysql=${true} \
    x
  ;;

stop)
  :
  ;;

*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
