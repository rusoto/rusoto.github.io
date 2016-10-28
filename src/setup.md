# Setting up Rusoto

Rusoto uses [Serde][serde] to provide serialization/deserialization for the Rust
data structures which represent the AWS API. Serde uses code generation in order
to generate `Serialize` and `Deserialize` implementations.

Serde allows for two separate ways of setting up code generation, depending on
whether your crate will be used with stable or nightly Rust. For stable Rust,
Serde uses a code generation library called [Syntex][syntex], along with a
[Cargo build script][cargo-build-script] to write out the generated code to a
file. For nightly Rust, Rusoto uses macros to generate the code.

Rusoto takes advantage of this to provide a hybrid approach: Rusoto uses Syntex
by default, but provides the ability to use macros on nightly Rust by using a
Cargo [feature][cargo-feature]. Via this method, users can choose to either
support stable and nightly, or both via feature flags.

* [Setup Rusoto targetting stable compiler][setup-stable]
* [Setup Rusoto targetting nightly compiler][setup-nightly]
* [Supporting both stable and nightly][setup-hybrid]

[cargo-build-script]: http://doc.crates.io/build-script.html
[cargo-feature]: http://doc.crates.io/manifest.html#the-features-section
[serde]: https://github.com/serde-rs/serde
[setup-hybrid]: https://rusoto.github.io/setup-hybrid.html
[setup-nightly]: https://rusoto.github.io/setup-nightly.html
[setup-stable]: https://rusoto.github.io/setup-stable.html
[syntex]: https://serde.rs/technical-details.html#syntex
