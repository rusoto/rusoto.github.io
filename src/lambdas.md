# Lambdas

Lambdas are a great place to use Rusoto! The runtime performance keeps costs down while the Rust language prevents classes of bugs found in other common languages used with AWS Lambda.

## Building for Lambda

Lambda environments are x86 64 bit Linux. Existing Rust code can be cross-compiled from a different platform for this target. For example, on a Macbook, one can compile a Linux executable for Lambda. See [Creating my first AWS Lambda using Rust](https://www.iamkonstantin.eu/blog/post-2018-12-02/) for more information on setup.

### Rustls

[Rustls](https://github.com/ctz/rustls) is `modern TLS library written in Rust`. It can replace OpenSSL in many places, including Rusoto. This makes it far easier to get a working lambda executable. No more `The OpenSSL library reported an error` on lambda startup because an OpenSSL flag isn't set right!

The `rustls` option must be set on the project's Cargo.toml file for both the `rusoto_core` crate and any Rusoto service crates used. For example, to use `rustls` with S3 and SQS:

```
rusoto_core = {version = "0.42.0", default_features = false, features=["rustls"]}
rusoto_s3 = {version = "0.42.0", default_features = false, features=["rustls"]}
rusoto_sqs = {version = "0.42.0", default_features = false, features=["rustls"]}
```

The default features must be disabled since that uses the `hyper-tls` crate. These flags can be found in the [rusoto_core Cargo.toml](https://github.com/rusoto/rusoto/blob/master/rusoto/core/Cargo.toml).
