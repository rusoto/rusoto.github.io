# Usage & Example

Rusoto provides a crate for each AWS service it supports, containing a client
and all of the associated types for that service. A full list of these services
can be found on the [Supported AWS Services][supported-aws-services] page.

It also provides a core crate called `rusoto_core`, containing all shared
functionality across services, such as the list of regions, signed request senders,
and credential loading.

Consult the rustdoc documentatation by running `cargo doc` or visiting the online
[API documentation][api-documentation] for the latest crates.io release.

An example of using Rusoto's DynamoDB API to list the names of all the
tables in a database:

Cargo.toml:

{% include "./dynamodb-example/Cargo.toml" %}

Rust code:

{% include "./dynamodb-example/src/main.rs" %}

[api-documentation]: https://rusoto.github.io/rusoto/rusoto/
[supported-aws-services]: /supported-aws-services.html
