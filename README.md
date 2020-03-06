# yugabyte-boshrelease

This is a [BOSH](http://bosh.io/) release for [YugabyteDB](https://github.com/yugabyte/yugabyte-db).

## ysql caveats

This currently only supports `YEDIS` and `YCQL` compatibilities. Enabling `YSQL` is something which will be worked on eventually, however other features like TLS, encryption, auth, and testing with `YCQL` and `YEDIS`, etc., are taking priorty.

## server-to-server tls

TLS is currently under development. For the time being it's opt-in using an operator file.

We use BOSH's credhub integration to generate individual certificates for both `master` and `tserver` instance groups leveraging [wildcard BOSH DNS values for the certificate SANs, meaning the actual hostname DNS values are handled automatically](https://bosh.io/docs/dns/). Since they're both signed by the same CA (by default located in credhub under `/services/tls_ca`, which is the CA for service instances which nearly all other service offerings in Cloud Foundry leverage for TLS), and each have the same `common_name`, they should be compatible with one another.

[It's a bit unclear how `common_name` and `alternative_names` should be configured](https://docs.yugabyte.com/latest/secure/tls-encryption/server-certificates/). Is it completely arbitrary? Does the file name actually matter? Does it have to be related to the DNS hostname of each node instance? We'll all figure it out _together_ 💖

For the moment we'll assume it's looking for the name to be the configured hostname of the individual host. We can assume this because of the following log line from `/var/vcap/sys/log/yb-master/yb-master.INFO`:

```log
tail yb-master.INFO
...
I0305 00:19:30.295537     6 secure.cc:102] Certs directory: /var/vcap/jobs/yb-master/config/certs, name: q-m90323n3s0.q-g88658.bosh
```

## client-to-server tls

Also in progress.

[Also also `YEDIS` does not support client-server TLS](https://docs.yugabyte.com/latest/secure/tls-encryption/)

## regarding rpc_bind and broadcast_bind

You might see lines like this in current configurations:

```erb
--rpc_bind_addresses=<%= spec.address %>:<%= p("rpc_bind_addresses_port") %>
--server_broadcast_addresses=<%= spec.address %>:<%= p("rpc_bind_addresses_port") %>
```

Notice how `--server_broadcast_addresses` is using an address with `rpc_bind_addresses_port` as the port. This is because the differences between `rpc_bind_addresses_port` and something like `server_broadcast_addresses_port` are too small at the moment to really make a huge difference, so _for the time being_ they're going to be collapsed into one, and only `rpc_bind_addresses_port` will be referenced. Is it correct? Honestly, not 100% sure. But don't worry we'll get there.

## cutting releases

Having a fully automated release process is a goal. But we want to make sure it's done well, and would like to have it done using github actions if possible. But until then, here's the general workflow. We're assuming any `bosh add-blobs` and `bosh upload-blobs` commands have been `git commit`'ed if blobs are changing, and now we're on the release process.

```sh
cd yugabyte-boshrelease

# first of all, your workspace needs to be up-to-date and clean of dirty commits,
# or else you'll commit something inadvertently to this release
git pull origin master

# to pull all blobs from s3 to local directory, if necessary
bosh sync-blobs

git checkout -b release-x.y.z

# place the release tgz in your /tmp dir in order to calculate a shasum on it, and to upload to a github release
bosh create-release --final --version=x.y.z --tarball=/tmp/yugabyte-x.y.z.tgz

# this will be used to update the versions.yml
shasum -a 1 /tmp/yugabyte-x.y.z.tgz

# use that shasum value to update the manifests/versions.yml
yugabyte_boshrelease_sha1: 582c112d4621361a031e530885f5653868f1bbd0
yugabyte_boshrelease_version: x.y.z

# git commit all of this to the branch
git commit -A
git commit -m "release-x.y.z"
git push origin release-x.y.z

# squash 'n merge it into master
```

now for making the release available as an actual github release:

```sh
# after squashing and merging into master...
git checkout master
git pull origin master

# notice the lack of 'v' prefix. not a fan of it.
git tag x.y.z
git push origin --tags
```

then go to the github releases page, click on the release for the newly created tag, and configure the release with a title, release notes, and an asset copy of the tarball from `/tmp/yugabyte-x.y.z.tgz`

voila, you're set.

## contributing

Ideas, feedback, bug reports, etc. are all welcome, _but_ by no means guaranteed to be implemented, responded to, or merged.
