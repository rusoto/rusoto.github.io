# Credential timeouts

If AWS credentials aren't found locally, Rusoto attempts to query the ECS container role provider, then the EC2 Instance Profile provider. When running locally, such as in a command line tool, timing out waiting for those services can take 30 seconds or more.

To improve responsiveness of credential sourcing, timeouts can be provided to the credential provider. This example uses a 200ms timeout:

```rust,no_run
extern crate rusoto_core;
extern crate rusoto_s3;

use rusoto_core::credential::ChainProvider;
use rusoto_core::request::HttpClient;
use rusoto_core::Region;
use rusoto_s3::{S3, S3Client};
use std::time::{Duration, Instant};

fn main() {
    let mut chain = ChainProvider::new();
    chain.set_timeout(Duration::from_millis(200));
    let s3client = S3Client::new_with(
        HttpClient::new().expect("failed to create request dispatcher"),
        chain,
        Region::UsEast1,
    );

    let start = Instant::now();
    println!("Starting up at {:?}", start);

    match s3client.list_buckets().sync() {
        Err(e) => println!("Error listing buckets: {}", e),
        Ok(buckets) => println!("Buckets found: {:?}", buckets),
    };
    println!("Took {:?}", Instant::now().duration_since(start));
}
```

Now, if Rusoto can't find any credentials within 200ms, it will return an error like this:

`Error listing buckets: Couldn't find AWS credentials in environment, credentials file, or IAM role.`

*Last updated for Rusoto 0.34.0 with rusoto_credential 0.13.0.*