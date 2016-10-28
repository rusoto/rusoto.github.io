# Supporting Both

If you are using both nightly and stable versions of the Rust compiler, you can
setup Rusoto to take advantage of [Serde's][serde] `serde_macros` for the
codegen on nightly, while also using Syntex on stable. This approach is similar
to the [stable approach][stable-approach], while also enabling active
development to occur on nightly with the faster `serde_macros` method.

Here is a `Cargo.toml` that depends on Rusoto's `unstable` features by default,
but also exposes a [feature][cargo-feature] to depend on Syntex instead:

```toml
[package]
name = "my-crate"
version = "0.1.0"
authors = ["My Name <my@email.com>"]

[dependencies.rusoto]
version = "0.18"
default-features = false
features = ["s3", "sqs"]

[features]
default = ["rusoto/unstable"]
with-syntex = ["rusoto/with-syntex"]
```

This `Cargo.toml` allows you to build on nightly with `cargo build`, and on
stable with the command:
`cargo build --no-default-features --features with-syntex`.

[cargo-feature]: http://doc.crates.io/manifest.html#the-features-section
[serde]: https://github.com/serde-rs/serde
[stable-approach]: https://rusoto.github.io/setup-stable.html
