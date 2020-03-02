# yugabyte-boshrelease

This is a [BOSH](http://bosh.io/) release for [YugabyteDB](https://github.com/yugabyte/yugabyte-db).

## ysql caveats

This currently only supports `YEDIS` and `YCQL` compatibilities. Enabling `YSQL` is something which will be worked on eventually, however other features like TLS, encryption, auth, and testing with `YCQL` and `YEDIS`, etc., are taking priorty.

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
