# Using Rusoto Futures

Rusoto Futures are like other Futures in Rust. They implement the `Future` trait:

```rust,ignore
Impl Future for RusotoFuture
```

Treating all calls to AWS services as asynchronous allows for different ways to handle network calls, potentially improving throughput and resource usage.

### All API calls return a future

All Rusoto calls to AWS [return a Future](https://rusoto.github.io/rusoto/rusoto_core/struct.RusotoFuture.html). This Future can be acted on immediately, saved for later use or chained/combined with other Futures before running.

### .sync()

Rusoto supports returning Futures to be executed later as well as synchronous, blocking calls. The [.sync()](https://rusoto.github.io/rusoto/rusoto_core/struct.RusotoFuture.html#method.sync) function on Rusoto Futures allows this behavior.

Under the hood it uses a `tokio::runtime` [to immediately run the Future.](https://github.com/rusoto/rusoto/blob/master/rusoto/core/src/future.rs).

### Chaining futures together

The usual collection of Future combinators can be used on Rusoto Futures. To read more about combinators, see [the tokio docs on Futures](https://tokio.rs/docs/futures/combinators/). Another resource to help sort out compiliation errors with Futures is the [Futures Cheatsheet](https://rufflewind.com/img/rust-futures-cheatsheet.html).

The example below uses the `.then()` combinator to chain multiple Futures together.

### Examples

See [Chaining Rusoto Futures](https://matthewkmayer.github.io/blag/public/post/chaining-rusoto-futures/) blog post for more information and links to complete examples.

```rust,no_run
extern crate futures;
extern crate rusoto_core;
extern crate rusoto_dynamodb;
extern crate tokio_core;

use futures::future::Future;
use rusoto_core::Region;
use rusoto_dynamodb::{
    AttributeDefinition, AttributeValue, CreateTableInput, CreateTableOutput, DynamoDb,
    DynamoDbClient, GetItemError, GetItemInput, GetItemOutput, KeySchemaElement,
    UpdateItemInput, UpdateItemOutput,
};
use std::collections::HashMap;
use tokio_core::reactor::Core;

fn main() {
    let item = make_item();
    let client = get_dynamodb_local_client();
    let mut core = Core::new().unwrap();

    let create_table_future = make_create_table_future(&client);
    let upsert_item_future = make_upsert_item_future(&client, &item);
    let item_from_dynamo_future = make_get_item_future(&client, &item);

    let chained_futures = create_table_future
        .then(|_| upsert_item_future)
        .then(|_| item_from_dynamo_future);

    let item_from_dynamo = match core.run(chained_futures) {
        Ok(item) => item,
        Err(e) => panic!("Error completing futures: {}", e),
    };
    println!("item: {:?}", item_from_dynamo);
}

fn make_create_table_future(client: &DynamoDbClient) -> 
  impl Future<Item = CreateTableOutput> {
    let attribute_def = AttributeDefinition {
        attribute_name: "foo_name".to_string(),
        attribute_type: "S".to_string(),
    };
    let k_schema = KeySchemaElement {
        attribute_name: "foo_name".to_string(),
        key_type: "HASH".to_string(), // case sensitive
    };
    let make_table_request = CreateTableInput {
        table_name: "a-testing-table".to_string(),
        attribute_definitions: vec![attribute_def],
        key_schema: vec![k_schema],
        ..Default::default()
    };

    client.create_table(make_table_request)
}

fn make_upsert_item_future(
    client: &DynamoDbClient,
    item: &HashMap<String, AttributeValue>,
) -> impl Future<Item = UpdateItemOutput> {
    let add_item = UpdateItemInput {
        key: item.clone(),
        table_name: "a-testing-table".to_string(),
        ..Default::default()
    };

    client.update_item(add_item)
}

fn make_get_item_future(
    client: &DynamoDbClient,
    item: &HashMap<String, AttributeValue>,
) -> impl Future<Item = GetItemOutput, Error = GetItemError> {
    // future for getting the entry
    let get_item_request = GetItemInput {
        key: item.clone(),
        table_name: "a-testing-table".to_string(),
        ..Default::default()
    };
    client.get_item(get_item_request)
}

fn make_item() -> HashMap<String, AttributeValue> {
    let item_key = "foo_name";
    let mut item = HashMap::new();
    item.insert(
        item_key.to_string(),
        AttributeValue {
            s: Some("baz".to_string()),
            ..Default::default()
        },
    );

    item
}

fn get_dynamodb_local_client() -> DynamoDbClient {
    // Create custom Region
    let region = Region::Custom {
        name: "us-east-1".to_owned(),
        endpoint: "http://localhost:8000".to_owned(),
    };

    DynamoDbClient::new(region)
}
```