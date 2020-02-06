#!/bin/bash

set -eu

LOG_DIR=/var/vcap/sys/log/yb-master
DATA_DIR=/var/vcap/store/yb-master

mkdir -p $LOG_DIR $DATA_DIR
exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  exec yb-master \
    --fs_data_dirs=${DATA_DIR} \
    --rpc_bind_addresses={{ spec.address }} \
    --server_broadcast_addresses={{ spec.address }}:7100 \
    --master_addresses=--{{ 'link("yb-master").instances.map { |instance| "#{instance.address}" }.join(",")' }} \
    --replication_factor={{ 'link("yb-master").instances.length' }} \
    --enable_ysql={{ '<%= p("enable_ysql") %>' }} \
    --stderrthreshold={{ '<%= p("stderrthreshold") %>' }} \
    --log_dir=${LOG_DIR}
  x
  ;;
  # logtostderr might be helpful?
  # --undefok=num_cpus,enable_ysql \
  # --num_cpus={{ ceil $root.Values.resource.master.requests.cpu }} \
  # --metric_node_name={{ HOSTNAME }} \
  # --memory_limit_hard_bytes={{ template "yugabyte.memory_hard_limit" $root.Values.resource.master }} \

stop)
  :
  ;;

*)
  echo "Usage: ${0} {start|stop}"
  exit 1
  ;;
esac
