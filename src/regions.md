# Regions

Rusoto supports all regions AWS supports. There is also a `Default` implementation that reads from environment variables `AWS_DEFAULT_REGION` or `AWS_REGION`. For more information and to see the list of regions, see the [Region API documentation](https://docs.rs/rusoto_core/latest/rusoto_core/region/enum.Region.html).

## Custom Regions

Custom Regions can be used for interacting with services that behave like AWS services, such as [Ceph](https://ceph.com/), [Minio](https://minio.io/) and [local DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html).

For a complete example of using local DynamoDB, see [this sample project](https://github.com/matthewkmayer/matthewkmayer.github.io/tree/master/samples/rusoto-local-dynamodb).

```rust,no_run
extern crate rusoto_core;
extern crate rusoto_dynamodb;

use rusoto_core::Region;
use rusoto_dynamodb::{DynamoDb, DynamoDbClient, ListTablesInput};

fn main() {
    // Create custom Region
    let region = Region::Custom {
        name: "us-east-1".to_owned(),
        endpoint: "http://localhost:8000".to_owned(),
    };

    let client = DynamoDbClient::new(region);

    let list_tables_request = ListTablesInput::default();
    let tables = client.list_tables(list_tables_request).sync();

    println!("Tables found: {:?}", tables);
}
```