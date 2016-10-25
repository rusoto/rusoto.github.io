# On Stable Compiler

Currently, the stable Rust compiler does not support compiler plugins, so Rusoto
uses [Syntex][syntex] along with a [Cargo build script][cargo-build-script] to
be able to use [Serde][serde] on stable. In the future, this will no longer be
necessary as support for compiler plugins matures.

**Advantages of this approach**: supports stable & nightly Rust versions because
it does not depend on any unstable features.

**Disadvantages of this approach**: Syntex significantly increases compile time.

To setup Rusoto to use this approach, use the following `Cargo.toml` as a
starting point:

```toml
[package]
name = "my-crate"
version = "0.1.0"
authors = ["My Name <my@email.com>"]

[dependencies.rusoto]
version = "0.18"
features = ["s3", "sqs"]
```

[cargo-build-script]: http://doc.crates.io/build-script.html
[serde]: https://github.com/serde-rs/serde
[syntex]: https://serde.rs/technical-details.html#syntex
