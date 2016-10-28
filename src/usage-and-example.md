# Usage & Example

Rusoto includes a public module for each AWS service it is compiled for, which
contains the Rust types for that service's API. A full list of these services
can be found on the [Supported AWS Services][supported-aws-services] page. All
other public types are reexported to the crate root. Consult the rustdoc
documentatation by running `cargo doc` or visiting the online
[API documentation][api-documentation] for the latest crates.io release.

A simple example of using Rusoto's DynamoDB API to list the names of all the
tables in a database:

```rust
extern crate rusoto;

use std::default::Default;

use rusoto::{DefaultCredentialsProvider, Region};
use rusoto::dynamodb::{DynamoDbClient, ListTablesInput};

fn main() {
  let provider = DefaultCredentialsProvider::new().unwrap();
  let client = DynamoDbClient::new(provider, Region::UsEast1);
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
[supported-aws-services]: https://rusoto.github.io/supported-aws-services.html
