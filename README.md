# yugabyte-boshrelease

This is a [BOSH](http://bosh.io/) release for [YugabyteDB](https://github.com/yugabyte/yugabyte-db).

## ysql caveats

This currently only supports `YEDIS` and `YCQL` compatibilities. Enabling the postgres API feature set, `YSQL`, requires a bit more fiddling with OS-level `locale` configuration; this is something which will be worked on eventually, however other features like TLS, encryption, auth, etc., are taking priorty.

## goals && antigoals

This release values and intends to...

- package and operationalize YugabyteDB for use in BOSH environments
- prioritize bounded contexts on configuration to reduce errors and cognitive overhead
- prioritize security by default
- prioritize simplicity, "reasonable" configuration, and practical deployment toplogies
- prioritize the release-management values of BOSH, e.g. versioning, packaging, and deploying in a reproducible manner

It is NOT intended, guaranteed, or prioritized to...

- deviate from supported or ideal configuration, topologies, etc.
- extend YB beyond it's core features

## contributing

Ideas, feedback, bug reports, use-cases, etc. are all welcome, _but_ by no means guaranteed to be implemented, responded to, or merged.
