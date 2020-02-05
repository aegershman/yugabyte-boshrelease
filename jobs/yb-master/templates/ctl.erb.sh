#!/bin/bash

set -eu

LOG_DIR=/var/vcap/sys/log/yb-master
mkdir -p $LOG_DIR
exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  :
  ;;
stop)
  :
  ;;
*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
