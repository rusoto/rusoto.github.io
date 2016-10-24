# Rusoto

Rusoto is an AWS SDK written in Rust.

Rusoto consists of two main crates, [rusoto](https://github.com/rusoto/rusoto/)
and [codegen](https://github.com/rusoto/rusoto/tree/master/codegen). The codegen
crate programmatically generates the source for the API using the AWS API
definitions provided by the [botocore](https://github.com/boto/botocore). This
generated code in then used to construct the rusoto crate, which provides the
low-level SDK functionality. Rusoto also provides a
[helpers](https://github.com/rusoto/rusoto/tree/master/helpers) crate which
provides higher-level abstractions for some of the AWS services (e.g. S3).
