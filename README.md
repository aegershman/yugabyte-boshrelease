# yugabyte-boshrelease

todo:

- placement uuid override? nah
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

- https://github.com/cloudfoundry-community/sample-python-flask-app-boshrelease/blob/master/packages/python/packaging
- https://github.com/bosh-packages/python-release/blob/master/packages/python-2.7/packaging
- https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
- https://github.com/yugabyte/yugabyte-installation/blob/master/test/yb-ctl-test.sh
- https://github.com/yugabyte/yugabyte-db/tree/master/src/yb/tserver
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
- looks like performance testing numbers are here? https://docs.yugabyte.com/latest/deploy/checklist/#amazon-web-services-aws

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

- https://github.com/cppforlife/zookeeper-release/blob/master/jobs/zookeeper/templates/zoo.cfg.erb
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

```log
scratchpad
goes
here
```
