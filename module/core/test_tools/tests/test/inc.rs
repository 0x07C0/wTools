use super::*;

mod basic_test;

#[ test_tools::rustversion::nightly ]
#[ test ]
fn trybuild_test()
{
  let t = trybuild::TestCases::new();
  t.pass( "tests/test/dynamic/trybuild.rs" );
  t.compile_fail( "tests/test/dynamic/namespace_does_not_exists.rs" );
}