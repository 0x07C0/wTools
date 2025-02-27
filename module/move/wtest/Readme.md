<!-- {{# generate.module_header{} #}} -->

# Module :: wtest
[![experimental](https://raster.shields.io/static/v1?label=stability&message=experimental&color=orange&logoColor=eee)](https://github.com/emersion/stability-badges#experimental) [![rust-status](https://github.com/Wandalen/wTools/actions/workflows/ModulewTestPush.yml/badge.svg)](https://github.com/Wandalen/wTools/actions/workflows/ModulewTestPush.yml) [![docs.rs](https://img.shields.io/docsrs/wtest?color=e3e8f0&logo=docs.rs)](https://docs.rs/wtest) [![Open in Gitpod](https://raster.shields.io/static/v1?label=try&message=online&color=eee&logo=gitpod&logoColor=eee)](https://gitpod.io/#RUN_PATH=.,SAMPLE_FILE=sample%2Frust%2Fwtest_trivial_sample%2Fsrc%2Fmain.rs,RUN_POSTFIX=--example%20wtest_trivial_sample/https://github.com/Wandalen/wTools) [![discord](https://img.shields.io/discord/872391416519737405?color=eee&logo=discord&logoColor=eee&label=ask)](https://discord.gg/m3YfbXpUUY)

Tools for writing and running tests.

## Sample

<!-- {{# generate.module_sample{} #}} -->

```rust
use wtest::*;

//

tests_impls!
{

  fn pass1()
  {
    assert_eq!( true, true );
  }

  //

  fn pass2()
  {
    assert_eq!( 1, 1 );
  }

}

//

tests_index!
{
  pass1,
  pass2,
}
```

### To add to your project

```sh
cargo add wtest --dev
```

### Try out from the repository

```sh
git clone https://github.com/Wandalen/wTools
cd wTools
cd sample/rust/test_trivial
cargo run
```
