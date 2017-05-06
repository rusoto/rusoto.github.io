<span style="float:right">[![github](/img/github.svg)](https://github.com/rusoto/rusoto) [![rustdoc](/img/rustdoc.svg)](https://rusoto.github.io/rusoto/rusoto/) [![Latest Version](https://img.shields.io/crates/v/rusoto.svg?style=social)](https://crates.io/crates/rusoto)</span>

# Rusoto

[Rusoto][rusoto] is an AWS SDK for Rust.

Rusoto consists of one [core][rusoto_core] crate, containing common functionality
shared across services, and then a crate for [each supported service](supported-aws-services.md).

Services are generated from the [botocore][botocore] project's API definitions.

In addition to the main crates, Rusoto also provides a [credential][credential]
and a [helpers][helpers] crate. The credential crate provides the necessary
functionality for properly loading and handling AWS credentials. The helpers
crate provides higher-level abstractions for some of the AWS services (e.g. S3),
however further development of the crate has been put on hold until the two main
crates have reached a stable state.

[rusoto]: https://github.com/rusoto/rusoto "Rusoto"
[rusoto_core]: https://github.com/rusoto/rusoto/tree/master/rusoto/core "Rusoto Core"
[credential]: https://github.com/rusoto/rusoto/tree/master/credential "Rusoto credential"
[botocore]: https://github.com/boto/botocore "Botocore"
[helpers]: https://github.com/rusoto/rusoto/tree/master/helpers "Rusoto helpers"
