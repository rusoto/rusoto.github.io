# Usage & Example

Rusoto includes a public module for each AWS service it is compiled for, which
contains the Rust types for that service's API. A full list of these services
can be found on the [Supported AWS Services][supported-aws-services] page. All
other public types are reexported to the crate root. Consult the rustdoc
documentatation by running `cargo doc` or visiting the online
[API documentation][api-documentation] for the latest crates.io release.

An example of using Rusoto's DynamoDB API to list the names of all the
tables in a database:

Cargo.toml:

```toml
[package]
name = "my-crate"
version = "0.1.0"
authors = ["My Name <my@email.com>"]

[dependencies.rusoto]
version = "0.23"
features = ["dynamodb"]
```

Rust code:

```rust
extern crate rusoto;

use std::default::Default;

use rusoto::{DefaultCredentialsProvider, Region};
use rusoto::dynamodb::{DynamoDbClient, ListTablesInput};
use rusoto::default_tls_client;

fn main() {
  let provider = DefaultCredentialsProvider::new().unwrap();
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
