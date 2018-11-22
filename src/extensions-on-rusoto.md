# Crates that extend Rusoto

Rusoto's current focus is to support all AWS services. This means higher level functionality present in other AWS SDKs are not currently available in Rusoto. See [https://github.com/rusoto/rusoto/issues/1098](https://github.com/rusoto/rusoto/issues/1098) for more information on where Rusoto efforts are currently focused.

While Rusoto doesn't support various higher level functionality or better ergonomics, there are third party crates available that use Rusoto and provide this behavior.

A non-exhaustive list of projects that build on Rusoto to make it more ergonomic or provide higher level functionality:

1. [dynomite](https://github.com/softprops/dynomite): `make your rust types fit dynamodb and visa versa`
2. [envy-store](https://github.com/softprops/envy-store): `deserialize AWS Parameter Store values into typesafe structs`
3. [S4](https://gitlab.com/pgerber/s4): `Simpler Simple Storage Service for Rust`

If you'd like to add an example to this list, please open an issue or pull request on the [rusoto.org repo](https://github.com/rusoto/rusoto.github.io).
