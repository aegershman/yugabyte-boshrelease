# yugabyte-boshrelease

todo:

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

bosh-links and goodies:

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

inspiration:

- https://docs.yugabyte.com/latest/deploy/public-clouds/aws/#manual-deployment
- https://github.com/cloudfoundry/exemplar-release
- https://github.com/cppforlife/zookeeper-release/blob/master/jobs/zookeeper/spec
- https://github.com/minio/minio-boshrelease/blob/master/jobs/minio-server/templates/ctl.erb#L65
- https://github.com/bosh-prometheus/prometheus-boshrelease/blob/master/jobs/prometheus2/templates/bin/prometheus_ctl
- https://github.com/concourse/concourse-bosh-release/blob/master/manifests/single-vm.yml
- https://github.com/jhunt/containers-boshrelease/tree/master/jobs/docker/templates

## scratchpad

https://docs.yugabyte.com/latest/deploy/multi-dc/3dc-deployment/

```sh
  --placement_cloud aws \
  --placement_region us-west \
  --placement_zone {{ '<%= spec.az %>' }} \
```

looks like performance testing numbers are here? https://docs.yugabyte.com/latest/deploy/checklist/#amazon-web-services-aws
