# Performance

Currently, performance isn't benchmarked.

To get the best runtime performance in a project using Rusoto, compile with the `--release` flag.  

For example: `cargo build --release`

### Increasing performance with large objects

As of Rusoto 0.36.0, we expose the `http1_read_buf_exact_size` setting in the `hyper` HTTP client. This can greatly improve performance dealing with payloads greater than 100MB. See [https://github.com/rusoto/rusoto/pull/1227](https://github.com/rusoto/rusoto/pull/1227) for more information.

Example of increasing the buffer size from the default of 8KB to 2MB:

```rust,no_run
extern crate rusoto_core;
extern crate rusoto_ecs;

use rusoto_ecs::{Ecs, EcsClient, ListClustersRequest};
use rusoto_core::{Region, DefaultCredentialsProvider};
use rusoto_core::request::{HttpClient, HttpConfig};

fn main() {
    // EcsClient configuration demonstrates setting the hyper read_buf_size option
    // to 2MB:
    let cred_provider =  DefaultCredentialsProvider::new().unwrap();
    let mut http_config_with_bigger_buffer = HttpConfig::new();
    http_config_with_bigger_buffer.read_buf_size(1024 * 1024 * 2);
    let http_provider = HttpClient::new_with_config(http_config_with_bigger_buffer).unwrap();

    let ecs = EcsClient::new_with(http_provider, cred_provider, Region::UsEast1);

    match ecs.list_clusters(ListClustersRequest::default()).sync() {
        Ok(clusters) => {
            for arn in clusters.cluster_arns.unwrap_or(vec![]) {
                println!("arn -> {:?}", arn);
            }
        }
        Err(err) => {
            panic!("Error listing container instances {:#?}", err);
        }
    }
}
```

### Potential runtime performance improvements

* [Improve XML parsing](https://github.com/rusoto/rusoto/issues/362)
