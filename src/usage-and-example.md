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

```toml
[package]
name = "my-crate"
version = "0.1.0"
authors = ["My Name <my@email.com>"]

[dependencies]
rusoto_core = "0.25.0"
rusoto_dynamodb = "0.25.0"
```

Rust code:

```rust
extern crate rusoto_core;
extern crate rusoto_dynamodb;

use std::default::Default;

use rusoto_core::{default_tls_client, DefaultCredentialsProvider, Region};
use rusoto_dynamodb::{DynamoDb, DynamoDbClient, ListTablesInput};

fn main() {
  let credentials = DefaultCredentialsProvider::new().unwrap();
  let client = DynamoDbClient::new(default_tls_client().unwrap(), credentials, Region::UsEast1);
  let list_tables_input: ListTablesInput = Default::default();

  match client.list_tables(&list_tables_input) {
    Ok(output) => {
      match output.table_names {
        Some(table_name_list) => {
          println!("Tables in database:");

          for table_name in table_name_list {
            println!("{}", table_name);
          }
        }
        None => println!("No tables in database!"),
      }
    }
    Err(error) => {
      println!("Error: {:?}", error);
    }
  }
}
```

[api-documentation]: https://rusoto.github.io/rusoto/rusoto/
[supported-aws-services]: /supported-aws-services.html
