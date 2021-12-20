
use former::Former;
use std::collections::HashMap;
use std::collections::HashSet;

#[derive( Debug, PartialEq, Former )]
pub struct Struct1
{
  #[former( default = 31 )]
  pub int_1 : i32,
  #[former( default = "abc" )]
  string_1 : String,
  #[former( default = 31 )]
  int_optional_1 : Option< i32 >,
  #[former( default = "abc" )]
  string_optional_1 : Option< String >,

  vec_1 : Vec< String >,
  hashmap_strings_1 : HashMap< String, String >,
  hashset_strings_1 : HashSet< String >,
}

//

fn test_complex() -> anyhow::Result< () >
{

  let command = Struct1::former()
  .form();
  // dbg!( &command );

  let expected = Struct1
  {
    int_1 : 31,
    string_1 : "abc".to_string(),
    int_optional_1 : Some( 31 ),
    string_optional_1 : Some( "abc".to_string() ),
    vec_1 : vec![],
    hashmap_strings_1 : maplit::hashmap!{},
    hashset_strings_1 : maplit::hashset!{},
  };
  assert_eq!( command, expected );

  Ok( () )
}

//

#[ test ]
fn main_test()
{
  test_complex().unwrap();
}
