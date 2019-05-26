<span style="float:right"><a href="https://github.com/rusoto/rusoto" target="_blank"><img src="img/github.svg" alt="github"></a> <a href="https://docs.rs/rusoto_core" target="_blank"><img src="img/rustdoc.svg" alt="rustdoc"></a> [![Latest Version](https://img.shields.io/crates/v/rusoto_core.svg?style=social)](https://crates.io/crates/rusoto_core)</span>

# Rusoto

[Rusoto][rusoto] is an AWS SDK for Rust.

Rusoto consists of one [core][rusoto_core] crate, containing common functionality
shared across services, and then a crate for [each supported service](supported-aws-services.md).

Services are generated from the [botocore][botocore] project's API definitions.

Rusoto also provides a [credential][credential] crate. The credential crate provides the necessary
functionality for properly loading and handling AWS credentials.

[rusoto]: https://github.com/rusoto/rusoto "Rusoto"
[rusoto_core]: https://github.com/rusoto/rusoto/tree/master/rusoto/core "Rusoto Core"
[credential]: https://github.com/rusoto/rusoto/tree/master/rusoto/credential "Rusoto credential"
[botocore]: https://github.com/boto/botocore "Botocore"
