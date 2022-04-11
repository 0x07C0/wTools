
use wtest_basic::*;

#[cfg( feature = "in_wtools" )]
use wtools::string as TheModule;
#[cfg( not( feature = "in_wtools" ) )]
use wstring_tools as TheModule;

// use TheModule::prelude::*;

//

fn _basic()
{

  // test.case( "delimeter : "b" );
  let src = "abc def";
  let iter = TheModule::string::split()
  .src( src )
  .delimeter( "bc" )
  .perform();
  // assert_eq!( iter.collect::< Vec< _ > >(), vec![ "a", "bc", " def" ] );
  assert_eq!( iter.map( | e | String::from( e ) ).collect::< Vec< _ > >(), vec![ "a", "bc", " def" ] );

}

//

test_suite!
{
  basic,
}
