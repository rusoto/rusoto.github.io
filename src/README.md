<span style="float:right">[![github](/img/github.svg)](https://github.com/rusoto/rusoto) [![rustdoc](/img/rustdoc.svg)]({{ book.domain }}/rusoto/rusoto/) [![Latest Version](https://img.shields.io/crates/v/rusoto.svg?style=social)](https://crates.io/crates/rusoto)</span>

# Rusoto

Rusoto is an AWS SDK written in Rust.

Rusoto consists of two main crates, [rusoto][rusoto] and [codegen][codegen]. The
codegen crate programmatically generates the source for the API using the AWS
API definitions provided by the [botocore][botocore] project. This generated
code is then used to construct the rusoto crate, which provides the low-level
SDK functionality. Rusoto also provides a [helpers][helpers] crate which
provides higher-level abstractions for some of the AWS services (e.g. S3).

[rusoto]: https://github.com/rusoto/rusoto "Rusoto"
[codegen]: https://github.com/rusoto/rusoto/tree/master/codegen "Rusoto codegen"
[botocore]: https://github.com/boto/botocore "Botocore"
[helpers]: https://github.com/rusoto/rusoto/tree/master/helpers "Rusoto helpers"
