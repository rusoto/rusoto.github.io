<span style="float:right">[![github](/img/github.svg)](https://github.com/rusoto/rusoto) [![rustdoc](/img/rustdoc.svg)]({{ book.domain }}/rusoto/rusoto/) [![Latest Version](https://img.shields.io/crates/v/rusoto.svg?style=social)](https://crates.io/crates/rusoto)</span>

# Rusoto

Rusoto is an AWS SDK written in Rust.

Rusoto consists of two main crates, [rusoto][rusoto] and [codegen][codegen]. The
codegen crate programmatically generates the source for the API using the AWS
API definitions provided by the [botocore][botocore] project. This generated
code is then used to construct the rusoto crate, which provides the low-level
SDK functionality.

In addition to the two main crates, Rusoto also provides a
[credential][credential] and a [helpers][helpers] crate. The credential crate
provides the necessary functionality for properly loading and handling AWS
credentials. The helpers crate provides higher-level abstractions for some of
the AWS services (e.g. S3), however further development of the crate has been
put on hold until the two main crates have reached a stable state.

[rusoto]: https://github.com/rusoto/rusoto "Rusoto"
[codegen]: https://github.com/rusoto/rusoto/tree/master/codegen "Rusoto codegen"
[credential]: https://github.com/rusoto/rusoto/tree/master/credential "Rusoto credential"
[botocore]: https://github.com/boto/botocore "Botocore"
[helpers]: https://github.com/rusoto/rusoto/tree/master/helpers "Rusoto helpers"
