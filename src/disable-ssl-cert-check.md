# Disabling SSL Certificate Check

The process of disabling an SSL cert check is not straight forward and requires
a few steps before using the services in Rusoto. The general steps are as follows:
1. Create a `TlsConnector` using the [TlsConnectorBuilder](https://docs.rs/native-tls/0.2.1/native_tls/struct.TlsConnectorBuilder.html).
Ensure the certificate check has been disabled. This is the important part!
2. Create a [HttpConnector](https://docs.rs/hyper/0.12.11/hyper/client/struct.HttpConnector.html),
this is needed to implement the From trait on the HttpsConnector.
3. Create a [HttpsConnector](https://docs.rs/hyper-tls/0.3.1/hyper_tls/struct.HttpsConnector.html)
using `from`, passing in the HTTP and TLS connectors.
4. Create a Rusoto `HttpClient` using the `from_connector` method.
5. Initialize a service using the `new_with` method.
6. Build Things!!!


```rust, no_run
extern crate hyper;
extern crate hyper_tls;
extern crate native_tls;
extern crate rusoto_core;
extern crate rusoto_s3;

use hyper::client::HttpConnector;
use hyper_tls::HttpsConnector;
use native_tls::TlsConnector;
use rusoto_core::{DefaultCredentialsProvider, HttpClient, Region};
use rusoto_s3::{S3Client, S3};

fn main() {
    // 1. create tls connector which accepts invalid certs
    let tls_connector: TlsConnector = TlsConnector::builder()
        .danger_accept_invalid_certs(true)
        .build()
        .expect("failed to build tls connector");

    // 2. create http connector
    let http_connector = HttpConnector::new(1);

    // 3. create https connector
    let https_connector = HttpsConnector::from((http_connector, tls_connector));

    // 4. create rusoto http client to be used in rusoto services
    let http_client = HttpClient::from_connector(https_connector);

    let cred_provider = DefaultCredentialsProvider::new().expect("failed to create cred provider");

    // 5. initialize service clients with new http client
    let s3_client = S3Client::new_with(http_client, cred_provider, Region::UsEast1);
    // 6. build!!!
    s3_client
        .list_buckets()
        .sync()
        .expect("failed to list buckets");
}
```
