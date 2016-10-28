# Debugging

Rusoto uses the [log][log-repo] logging facade. For tests, Rusoto uses
[`env_logger`][crates-io-env_logger].

In order to see logging output (e.g. the actual requests made to AWS),
`env_logger` needs to be initialized:

```rust
#[test]
fn list_objects_test() {
    let _ = env_logger::init(); // This initializes the `env_logger`

    let bare_s3 = S3Client::new(
        DefaultCredentialsProvider::new().unwrap(),
        Region::UsWest2
    );
    let mut list_request = ListObjectsRequest::default();
    list_request.bucket = "rusototester".to_string();
    let result = bare_s3.list_objects(&list_request).unwrap();
    println!("result is {:?}", result);
}
```

To see the output of logging from integration tests, the command needs to be run
as follows:

```
RUST_LOG=debug cargo test --features all
```

To get the logging output as well as the output of any `println!` statements,
run:

```
RUST_LOG=debug cargo test --features all -- --nocapture
```

[crates-io-env_logger]: https://crates.io/crates/env_logger
[log-repo]: https://github.com/rust-lang-nursery/log
