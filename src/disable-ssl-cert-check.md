# Disabling SSL Certificate Check

## ⚠️ Danger ⚠️

Disabling certificate checking is not part of regular use of Rusoto. There are very few legitimate reasons to disable default behavior. Production use of Rusoto should not use the behavior documented on this page. Use of AWS services should **not** disable certificate checking.

Use this only if you know what you're doing.

## Opting out of certificate checking

The process of disabling an SSL cert check requires
a few steps before using the services in Rusoto. The general steps are as follows:
1. Create a `TlsConnector` using the [TlsConnectorBuilder](https://docs.rs/native-tls/0.2.1/native_tls/struct.TlsConnectorBuilder.html).
Ensure the certificate check has been disabled. This is the important part!
2. Create a [HttpConnector](https://docs.rs/hyper/0.12.11/hyper/client/struct.HttpConnector.html),
this is needed to implement the From trait on the HttpsConnector.
3. Create a [HttpsConnector](https://docs.rs/hyper-tls/0.3.1/hyper_tls/struct.HttpsConnector.html)
using `from`, passing in the HTTP and TLS connectors.
4. Create a Rusoto `HttpClient` using the `from_connector` method.
5. Initialize a service using the `new_with` method.
6. Build Things!


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

    // 2. create http connector - make sure to not enforce http
    let mut http_connector = HttpConnector::new(4);
    http_connector.enforce_http(false);

    // 3. create https connector
    let https_connector = HttpsConnector::from((http_connector, tls_connector));

    // 4. create rusoto http client to be used in rusoto services
    let http_client = HttpClient::from_connector(https_connector);

    let cred_provider = DefaultCredentialsProvider::new().expect("failed to create cred provider");

    // custom region to talk to local service with a self-signed cert
    let local_region = Region::Custom {
        name: "us-east-1".to_owned(),
        endpoint: "https://localhost:8000".to_owned(),
    };
    // 5. initialize service clients with new http client
    let s3_client = S3Client::new_with(http_client, cred_provider, local_region);
    // 6. build!
    s3_client
        .list_buckets()
        .sync()
        .expect("failed to list buckets");
}
```

## ⚠️ Danger ⚠️

Do not use this for communicating to AWS services. Use this only for AWS-like services such as Ceph or Minio and generating trusted certificates is not possible.
