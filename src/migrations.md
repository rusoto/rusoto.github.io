# Migrations

### Rusoto Versions < 0.38.0 to Versions >= 0.38.0 Error Handling
Rusoto version 0.38.0 introduced the enum `rusoto_core::RusotoError`. In versions
before 0.38.0 errors would be typed as themselves such as  `rusoto_s3::CreateBucketError`.
In versions >= 0.38.0 the service method errors would be wrapped in the new enum,
such as `rusoto_core::RusotoError<rusoto_s3::CreateBucketError>`.

Rusoto < 0.38.0:

```rust, ignore
extern crate rusoto_core;
extern crate rusoto_s3;

use rusoto_core::Region;
use rusoto_s3::{CreateBucketError, CreateBucketOutput, CreateBucketRequest, S3Client, S3};

fn main() {
    let s3_client = S3Client::new(Region::UsEast1);
    let bucket_name = "itshabib-buckets".to_owned();

    match create_bucket_sync(&s3_client, bucket_name.clone()) {
        Ok(res) => println!("successfully created bucket! resp: {:#?}", res),
        Err(err) => println!("Error creating bucket. err: {:#?}", err),
    };
}


// error handling for versions < 0.38
fn create_bucket_sync(
    s3_client: &S3Client,
    bucket_name: String,
    // errors are not wrapped by RusotoError in version < 0.38
) -> Result<CreateBucketOutput, CreateBucketError> {
    let create_bucket_req = CreateBucketRequest {
        bucket: bucket_name.clone(),
        ..Default::default()
    };

    s3_client.create_bucket(create_bucket_req).sync()
}
```

Rusoto >= 0.38.0:
```rust, no_run
extern crate rusoto_core;
extern crate rusoto_s3;

use rusoto_core::{Region, RusotoError};
use rusoto_s3::{CreateBucketError, CreateBucketOutput, CreateBucketRequest, S3Client, S3};

fn main() {
    let s3_client = S3Client::new(Region::UsEast1);
    let bucket_name = "itshabib-buckets".to_owned();

    match create_bucket_sync(&s3_client, bucket_name.clone()) {
        Ok(res) => println!("successfully created bucket! resp: {:#?}", res),
        Err(err) => println!("Error creating bucket. err: {:#?}", err),
    };
}

// error handling for versions >= 0.38
fn create_bucket_sync(
    s3_client: &S3Client,
    bucket_name: String,
    // service method error is wrapped in RusotoError enum
) -> Result<CreateBucketOutput, RusotoError<CreateBucketError>> {
    let create_bucket_req = CreateBucketRequest {
        bucket: bucket_name.clone(),
        ..Default::default()
    };

    s3_client.create_bucket(create_bucket_req).sync()
}

```

### Rusoto 0.31.0 to 0.32.0

With `async` support, the easiest migration is to use the new `simple()` constructor on clients and add `.sync()` to the function calls.

Rusoto 0.31.0:

```rust,ignore
extern crate rusoto_core;
extern crate rusoto_polly;

use rusoto_polly::{Polly, PollyClient, DescribeVoicesInput};
use rusoto_core::{DefaultCredentialsProvider, Region, default_tls_client};

...
let credentials = DefaultCredentialsProvider::new().unwrap();
let client = PollyClient::new(default_tls_client().unwrap(), credentials, Region::UsEast1);
let request = DescribeVoicesInput::default();


println!("{:?}", client.describe_voices(&request).unwrap());
```

Rusoto 0.32.0 with async:

```rust,ignore
extern crate rusoto_core;
extern crate rusoto_polly;

use rusoto_polly::{Polly, PollyClient, DescribeVoicesInput};
use rusoto_core::Region;

...
let client = PollyClient::simple(Region::UsEast1);
let request = DescribeVoicesInput::default();

println!("{:?}", client.describe_voices(&request).sync().unwrap());
```

Note:
* `DefaultCredentialsProvider` isn't required with the `::simple()` constructor
* `default_tls_client` isn't required with the `::simple()` constructor
* `.sync()` is called on the result from `describe_voices`. This blocks until the call is finished.

### Rusoto 0.24.0 to 0.25.0 or later

As of Rusoto 0.25.0, the [Rusoto crate](https://crates.io/crates/rusoto) is now deprecated.  This decision was made because the single crate implementing all AWS services was too large to compile, especially on TravisCI and Appveyor.  The new main crate is `rusoto_core` and all services now have their own crate.

To continue implementing new services and reducing compilation times, we've extracted a few core crates and every AWS service we support now has its own crate.

`rusoto_core` now contains the core functionality of Rusoto: AWS signature handling, regions, requests to services and XML helpers.

`rusoto_mock` was also extracted.  Crate users shouldn't need this: it's for developing on Rusoto itself.

`rusoto_credential` remains its own crate, providing AWS credential sourcing.  If you're working on something that uses AWS and Rusoto doesn't support it, you can use that crate instead of rolling your own AWS credential providers.

The new service crates depend on `rusoto_core`.

#### Required changes

Previously, to bring in a Rusoto implementation of an AWS service, you'd specify something like this in your Cargo.toml file:

```toml
rusoto = {version = "0.24", features = ["rds"]}
```

Now, you'd bring in services like this:

```toml
rusoto_core = {version = "0.25.0"}
rusoto_rds = {version = "0.25.0"}
```

Once the new crates have been brought in, use the new crates in your code.  A sample before:

```rust,ignore
extern crate rusoto;

use rusoto::rds::{RdsClient, CreateDBInstanceMessage, DescribeDBInstancesMessage};
use rusoto::{DefaultCredentialsProvider, Region, default_tls_client};
```

And after:

```rust,ignore
extern crate rusoto_core;
extern crate rusoto_rds;
use rusoto_rds::{Rds, RdsClient, CreateDBInstanceMessage, DescribeDBInstancesMessage};
use rusoto_core::{DefaultCredentialsProvider, Region, default_tls_client};
```

Note there are now two crates required: `rusoto_core` as well as the RDS crate, `rusoto_rds`.  There's also a new trait for each service.  In this case it's `Rds` and we bring that in.  This is used to make calls to services easier to test and improve ergonomics of using Rusoto clients.
