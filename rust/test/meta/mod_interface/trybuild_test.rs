
#[ allow( unused_imports ) ]
use super::*;
#[ allow( unused_imports ) ]
use test_tools::exposed::*;

#[ test_tools::rustversion::nightly ]
tests_impls!
{

  fn trybuild_tests()
  {
    use test_tools::dependencies::trybuild;
    println!( "current_dir : {:?}", std::env::current_dir().unwrap() );
    let t = trybuild::TestCases::new();

    t.pass( "../../../rust/test/meta/mod_interface/front/layer/trybuild.rs" );
    t.pass( "../../../rust/test/meta/mod_interface/front/micro_modules/trybuild.rs" );
    t.pass( "../../../rust/test/meta/mod_interface/front/micro_modules_two/trybuild.rs" );
    t.pass( "../../../rust/test/meta/mod_interface/front/micro_modules_two_joined/trybuild.rs" );

    t.compile_fail( "../../../rust/test/meta/mod_interface/front/micro_modules_bad_vis/trybuild.rs" );
    t.compile_fail( "../../../rust/test/meta/mod_interface/front/micro_modules_unknown_vis/trybuild.rs" );

  }

}

#[ test_tools::rustversion::nightly ]
tests_index!
{
  trybuild_tests,
}