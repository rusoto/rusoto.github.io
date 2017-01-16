# Performance

Currently, performance isn't benchmarked.

To get the best runtime performance in a project using Rusoto, compile with the `--release` flag.  

For example: `cargo build --release`

### Potential runtime performance improvements

* [Improve XML parsing](https://github.com/rusoto/rusoto/issues/362)
* [Get object by stream](https://github.com/rusoto/rusoto/issues/481)

### Potential compile time improvements

* [Reduce compilation memory usage](https://github.com/rusoto/rusoto/issues/513)
* [Run less code through serde](https://github.com/rusoto/rusoto/issues/506)
