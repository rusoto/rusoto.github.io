# On Nightly Compiler

If you are using a nightly version of the compiler, you can setup Rusoto to use
[Serde's][serde] `serde_derive` for the codegen.

**Advantages of this approach**: none of the disadvantages of the
[stable approach][stable-approach].

**Disadvantages of this approach**: depends on an unstable Rust feature, so
requires the usage of nightly Rust.

To setup Rusoto to use this approach, use the following `Cargo.toml` as a
starting point:

```toml
[package]
name = "my-crate"
version = "0.1.0"
authors = ["My Name <my@email.com>"]

[dependencies.rusoto]
version = "0.18"
default-features = false
features = ["s3", "sqs", "unstable"]
```

[serde]: https://github.com/serde-rs/serde
[stable-approach]: /setup-stable.html
