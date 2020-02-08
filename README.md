# yugabyte-boshrelease

todo:

- placement uuid override?
- is the reference doc accurate in reference to csql proxies and such...?
- create a compiled release? https://bosh.io/docs/compiled-releases/
- schedule cleanups or whatever the helm chart was doing? https://bosh.io/docs/scheduled-procs/ https://github.com/yugabyte/charts/blob/master/stable/yugabyte/templates/service.yaml#L228
- check cluster-config as an errand? https://docs.yugabyte.com/latest/deploy/manual-deployment/start-tservers/#set-replica-placement-policy
- cleanup blobstore and packaging logic, use more astericks and such
- test
- errand script similar to minio https://github.com/minio/minio-boshrelease/blob/master/manifests/manifest-fs-example.yml#L61
- errands for status, ctl, cleanup, etc
- yb-ctl for a single local cluster as a job
- syslog operators
- web operators
- certificates in a certs dir, maybe steal from rmq or other releases
- licensing...?
- bpm... maybe just templatize the entire bpm yml as an erb?
- more security options
- logtostderr might be helpful
- prometheus?
- creds?
- activating yedis, ysql, etc?
- better pkill options, similar to zookeeper release, or maybe just bpm?
- instead of monit or bpm, put flags options in a specific file and use --flagfile
- preload users similar to postgres release?

reference links:

- can also see all the flags configured or available on a given master or tserver by going to `host:port/varz`
- https://download.yugabyte.com/#linux
- https://docs.yugabyte.com/latest/secure/authentication/ysql-authentication/
- https://docs.yugabyte.com/latest/secure/security-checklist/#rpc-bind-interfaces
- https://docs.yugabyte.com/latest/reference/configuration/default-ports/
- https://docs.yugabyte.com/latest/admin/yb-ctl/#logs
- https://github.com/yugabyte/charts/blob/master/stable/yugabyte/templates/service.yaml#L228
- https://github.com/yugabyte/yugabyte-db/blob/b68b84bfd46b6a771d828c66477a477aa0f71844/src/yb/tserver/tablet_server_main.cc#L91-L97
- https://docs.yugabyte.com/latest/reference/configuration/yb-master/
- https://docs.yugabyte.com/latest/reference/configuration/yb-master/#security-options
- https://docs.yugabyte.com/latest/deploy/manual-deployment/verify-deployment/
- https://docs.yugabyte.com/latest/deploy/manual-deployment/
- https://docs.yugabyte.com/latest/deploy/manual-deployment/start-masters/
- https://docs.yugabyte.com/latest/deploy/public-clouds/aws/#manual-deployment
- https://docs.yugabyte.com/latest/quick-start/create-local-cluster/
- https://docs.yugabyte.com/latest/deploy/docker/docker-compose/
- https://docs.yugabyte.com/latest/deploy/manual-deployment/start-tservers/#run-yb-tserver-with-configuration-file
- upgrade guide https://docs.yugabyte.com/latest/manage/upgrade-deployment/ and here https://docs.yugabyte.com/latest/manage/change-cluster-config/
- data migration here, looks like a cli which shows percentage of stuff done https://docs.yugabyte.com/latest/manage/change-cluster-config/#4-perform-data-move
- diagnostic reporting config https://docs.yugabyte.com/latest/manage/diagnostics-reporting/#configuration-options
- build local and tests https://docs.yugabyte.com/latest/contribute/core-database/build-from-src/#ubuntu18
- advanced auth https://docs.yugabyte.com/latest/secure/authentication/client-authentication/
- https://docs.yugabyte.com/latest/deploy/kubernetes/oss/yugabyte-operator/
- https://docs.yugabyte.com/latest/deploy/kubernetes/best-practices/
- https://docs.yugabyte.com/latest/deploy/manual-deployment/start-tservers/ wait maybe the total replication factor should always for sure be the same as the number of nodes?
- https://docs.yugabyte.com/latest/deploy/manual-deployment/verify-deployment/#connect-clients
- https://docs.yugabyte.com/latest/troubleshoot/overview/
- logs https://docs.yugabyte.com/latest/troubleshoot/nodes/check-logs/
- https://docs.yugabyte.com/latest/manage/upgrade-deployment/#upgrade-yb-tservers
- https://docs.yugabyte.com/latest/reference/configuration/default-ports/

bosh-links and goodies:

- https://content.pivotal.io/blog/troubleshooting-bosh-releases-deployments
- https://bosh.io/docs/drain/
- https://bosh.io/docs/pre-start/
- https://bosh.io/docs/job-lifecycle/
- https://www.cloudfoundry.org/blog/create-lean-bosh-release/
- https://bosh.io/docs/errands/
- https://bosh.io/docs/bpm/config/#example
- https://gist.github.com/Amit-PivotalLabs/c39528248b8cdc4ba8e347f8aa68abb6#about-that-link-object-and-its-instances0-and-the-address-accessor
- https://bosh.io/docs/bpm/config/
- https://bosh.io/docs/links/#templates
- https://bosh.io/docs/links-properties/
- https://bosh.io/docs/links/#self
- https://bosh.io/docs/jobs/#properties
- https://bosh.io/docs/jobs/#properties-spec
- https://bosh.io/docs/drain/
- https://bosh.io/docs/instance-metadata/
- https://ultimateguidetobosh.com/instances/#persistent-volumes
- https://ultimateguidetobosh.com/disks/
- https://docs.pivotal.io/svc-sdk/odb/0-37/adapter-reference.html
- bosh bpm capabilities http://man7.org/linux/man-pages/man7/capabilities.7.html
- https://www.gnu.org/software/tar/manual/html_node/Option-Summary.html#SEC42

inspiration:

- https://github.com/alphagov/paas-collectd-boshrelease/blob/master/jobs/collectd/templates/data/properties.sh.erb
- https://github.com/cloudfoundry-incubator/kubo-release/blob/master/jobs/kubelet/templates/bin/kubelet_ctl.erb
- https://github.com/bosh-prometheus/prometheus-boshrelease/blob/master/packages/firehose_exporter/packaging
- https://docs.yugabyte.com/latest/deploy/public-clouds/aws/#manual-deployment
- https://github.com/cloudfoundry/exemplar-release
- https://github.com/cppforlife/zookeeper-release/blob/master/jobs/zookeeper/spec
- https://github.com/minio/minio-boshrelease/blob/master/jobs/minio-server/templates/ctl.erb#L65
- https://github.com/bosh-prometheus/prometheus-boshrelease/blob/master/jobs/prometheus2/templates/bin/prometheus_ctl
- https://github.com/concourse/concourse-bosh-release/blob/master/manifests/single-vm.yml
- https://github.com/jhunt/containers-boshrelease/tree/master/jobs/docker/templates
- https://github.com/pivotal-cf/cf-rabbitmq-multitenant-broker-release/
- https://github.com/pivotal-cf/cf-rabbitmq-release

## scratchpad

https://docs.yugabyte.com/latest/deploy/multi-dc/3dc-deployment/

```sh
  --placement_cloud aws \
  --placement_region us-west \
  --placement_zone {{ '<%= spec.az %>' }} \
```

looks like performance testing numbers are here? https://docs.yugabyte.com/latest/deploy/checklist/#amazon-web-services-aws

```yml
# bpm example
---
processes:
  - name: yb-master
    executable: /var/vcap/data/packages/yb-master/yb-master
    args: []
    ephemeral_disk: true

  - name: worker
    executable: /var/vcap/data/packages/worker/work.sh
    limits:
      processes: 10
    args:
      - --queues
      - 4
    env:
      FOO: BAR
    additional_volumes:
      - path: /var/vcap/data/sockets
        writable: true
    hooks:
      pre_start: /var/vcap/jobs/server/bin/worker-setup
      capabilities:
        - NET_BIND_SERVICE
```

old `tserver` monit when it's using ctl:

```txt
check process yb-tserver
  with pidfile /var/vcap/sys/run/yb-tserver/yb-tserver.pid
  start program "/var/vcap/jobs/yb-tserver/bin/ctl start"
  stop program "/var/vcap/jobs/yb-tserver/bin/ctl stop"
  group vcap
```

and old `tserver` ctl.erb.sh:

```sh
#!/bin/bash

set -eu

RUN_DIR=/var/vcap/sys/run/yb-tserver
LOG_DIR=/var/vcap/sys/log/yb-tserver
DATA_DIR=/var/vcap/store/yb-tserver
PIDFILE=${RUN_DIR}/pid

mkdir -p ${RUN_DIR} ${LOG_DIR} ${DATA_DIR}
exec 1>>"${LOG_DIR}/ctl.stdout.log"
exec 2>>"${LOG_DIR}/ctl.stderr.log"

case $1 in
start)
  echo $$ >${PIDFILE}

  exec yb-tserver \
    --fs_data_dirs=${DATA_DIR} \
    --rpc_bind_addresses={{ '<%= spec.address %>' }}:9100 \
    --server_broadcast_addresses={{ '<%= spec.address %>' }}:9100 \
    --tserver_master_addrs={{ 'link("yb-master").instances.map { |instance| "#{instance.address}:7100" }.join(",")' }} \
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
```

```log
cat /var/vcap/store/yb-master/yb-data/master/logs

F20200207 20:03:35 ../../../../../src/yb/master/catalog_manager.cc:620] Failed to load sys catalog: IO error (yb/util/env_posix.cc:1461): /var/vcap/data/packages/yugabyte/09671344d97ee046781adc20ac253fe86782e1ac/share/initial_sys_catalog_snapshot/exported_tablet_metadata_changes: Permission denied (system error 13)
    @     0x7f8f5490c56c  yb::LogFatalHandlerSink::send()
    @     0x7f8f53b00d16  google::LogMessage::SendToLog()
    @     0x7f8f53afe79a  google::LogMessage::Flush()
    @     0x7f8f53b01869  google::LogMessageFatal::~LogMessageFatal()
    @     0x7f8f5da79f27  yb::master::CatalogManager::LoadSysCatalogDataTask()
    @     0x7f8f5499d704  yb::ThreadPool::DispatchThread()
    @     0x7f8f54999e0f  yb::Thread::SuperviseThread()
    @     0x7f8f50361694  start_thread
    @     0x7f8f4fa9e41d  __clone
    @              (nil)  (unknown)
```

---

content of `post_install.sh`:

```sh
#!/usr/bin/env bash

# Post-installation script. Set dynamic linker path on executables in the "bin" directory. This
# script is expected to be installed into the "bin" directory of the YugaByte distribution.

#
# The following only applies to changes made to this file as part of YugaByte development.
#
# Portions Copyright (c) YugaByte, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied.  See the License for the specific language governing permissions and limitations
# under the License.
#
set -euo pipefail

patch_binary() {
  if [[ $# -ne 1 ]]; then
    echo >&2 "patch_binary expects exactly one argument, the binary name to patch"
    exit 1
  fi
  local f=$1
  (
    set -x;
    "$patchelf_path" --set-interpreter "$ld_path" "$f";
    "$patchelf_path" --set-rpath "$rpath" "$f";
  )
}

bin_dir=$( cd "${BASH_SOURCE%/*}" && pwd )
distribution_dir=$( cd "$bin_dir/.." && pwd )
lib_dir="$distribution_dir/lib"
linuxbrew_dir="$distribution_dir/linuxbrew"
rpath="$lib_dir/yb:$lib_dir/yb-thirdparty:$linuxbrew_dir/lib"
patchelf_path=$bin_dir/patchelf
script_name=$(basename "$0")
completion_file="$distribution_dir/.${script_name}.completed"

if [[ -f $completion_file ]];
then
  echo "${script_name} was already run (marker at ${completion_file})"
  exit
fi

if [[ ! -x $patchelf_path ]]; then
  echo >&2 "patchelf not found or is not executable: '$patchelf_path'"
  exit 1
fi

ld_path=$distribution_dir/lib/ld.so

if [[ ! -x $ld_path ]]; then
  echo >&2 "Dynamic linker not found or is not executable: '$ld_path'"
  exit 1
fi

cd "$bin_dir"
# ${...} macro variables will be substituted during packaging.
for f in "log-dump" "ldb" "sst_dump" "yb-admin" "yb-bulk_load" "yb-generate_partitions_main" "yb_load_test_tool" "yb-master" "yb-pbc-dump" "yb-ts-cli" "yb-tserver" "yb-ysck" "redis-cli"; do
  patch_binary "$f"
done

cd "$bin_dir/../postgres/bin"
for f in "postgres" "postmaster" "ecpg" "initdb" "pg_archivecleanup" "pg_basebackup" "pg_receivewal" "pg_recvlogical" "pg_config" "pg_controldata" "pg_ctl" "ysql_dump" "pg_restore" "ysql_dumpall" "pg_resetwal" "pg_rewind" "pg_test_fsync" "pg_test_timing" "pg_upgrade" "pg_verify_checksums" "pg_waldump" "ysql_bench" "ysqlsh" "createdb" "dropdb" "createuser" "dropuser" "clusterdb" "vacuumdb" "reindexdb" "pg_isready" "oid2name" "pg_standby" "vacuumlo"; do
  patch_binary "$f"
done

# We are filtering out warning from stderr which are produced by this bug:
# https://github.com/NixOS/patchelf/commit/c4deb5e9e1ce9c98a48e0d5bb37d87739b8cfee4
# This bug is harmless, it only could unnecessarily increase file size when patching.
find "$lib_dir" "$linuxbrew_dir" -name "*.so*" ! -name "ld.so*" -exec "$patchelf_path" \
  --set-rpath "$rpath" {} 2> \
  >(grep -v 'warning: working around a Linux kernel bug by creating a hole' >&2) \;

ORIG_BREW_HOME=/n/jenkins/linuxbrew/linuxbrew-20181203T161736-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
ORIG_LEN=${#ORIG_BREW_HOME}

# Take $ORIG_LEN number of '\0' from /dev/zero, replace '\0' with 'x', then prepend to
# "$distribution_dir/linuxbrew-" and keep first $ORIG_LEN symbols, so we have a path of $ORIG_LEN
# length.
BREW_HOME=$(echo "$distribution_dir/linuxbrew-$(head -c "$ORIG_LEN" </dev/zero | tr '\0' x)" | \
  cut -c-"$ORIG_LEN")
LEN=${#BREW_HOME}
if [[ "$LEN" != "$ORIG_LEN" ]]; then
 echo "Linuxbrew should be linked to a directory having absolute path length of $ORIG_LEN bytes," \
      "but actual length is $LEN bytes."
 exit 1
fi

ln -sfT "$linuxbrew_dir" "$BREW_HOME"

find "$distribution_dir" -type f -not -path "$distribution_dir/yugabyte-logs/*" \
   -exec sed -i --binary "s%$ORIG_BREW_HOME%$BREW_HOME%g" {} \;

touch "$completion_file"
```

---

```log
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | ==> /var/vcap/sys/log/yb-master/yb-master.stderr.log <==
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | I0207 20:44:41.636562    21 db_impl.cc:747] T 00000000000000000000000000000000 P 7f2a1353893848949e76ad428bcc0680 [R]: Shutdown done
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | E0207 20:44:41.636597    21 tablet.cc:581] T 00000000000000000000000000000000 P 7f2a1353893848949e76ad428bcc0680: Failed to open a RocksDB database in directory /var/vcap/store/yb-master/yb-data/master/data/rocksdb/table-sys.catalog.uuid/tablet-00000000000000000000000000000000: IO error (yb/rocksdb/util/env_posix.cc:599): /var/vcap/store/yb-master/yb-data/master/data/rocksdb/table-sys.catalog.uuid/tablet-00000000000000000000000000000000/MANIFEST-000011: No such file or directory
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | I0207 20:44:41.636652    21 tablet_bootstrap.cc:428] T 00000000000000000000000000000000 P 7f2a1353893848949e76ad428bcc0680: Time spent opening tablet: real 0.002s user 0.002s     sys 0.000s
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | I0207 20:44:41.636696    21 transaction_participant.cc:853] T 00000000000000000000000000000000 P 7f2a1353893848949e76ad428bcc0680: Stop
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | E0207 20:44:41.636781    21 master.cc:241] Master@10.156.89.36:7100: Unable to init master catalog manager: Illegal state (yb/tablet/tablet.cc:586): Unable to initialize catalog manager: Failed to initialize sys tables async: IO error (yb/rocksdb/util/env_posix.cc:599): /var/vcap/store/yb-master/yb-data/master/data/rocksdb/table-sys.catalog.uuid/tablet-00000000000000000000000000000000/MANIFEST-000011: No such file or directory
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | E0207 20:44:41.636842     6 main_util.cc:22] Illegal state (yb/tablet/tablet.cc:586): Unable to initialize catalog manager: Failed to initialize sys tables async: IO error (yb/rocksdb/util/env_posix.cc:599): /var/vcap/store/yb-master/yb-data/master/data/rocksdb/table-sys.catalog.uuid/tablet-00000000000000000000000000000000/MANIFEST-000011: No such file or directory
master/06f28e2a-8714-47f2-9700-268799010bcc: stdout | I0207 20:44:41.636868     6 master.cc:284] Master@10.156.89.36:7100 shutting down...
```
