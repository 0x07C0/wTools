
fn main()
{
  #[ cfg( all( feature = "derive_from", feature = "derive_into", feature = "derive_display", feature = "derive_from_str" ) ) ]
  {
    use derive_tools::*;

    #[ derive( From, Into, Display, FromStr, PartialEq, Debug ) ]
    #[ display( "{a}-{b}" ) ]
    struct Struct1
    {
      a : i32,
      b : i32,
    }

    // derived Into
    let src = Struct1 { a : 1, b : 3 };
    let got : ( i32, i32 ) = src.into();
    let exp = ( 1, 3 );
    assert_eq!( got, exp );

    // derived Display
    let src = Struct1 { a : 1, b : 3 };
    let got = format!( "{}", src );
    let exp = "1-3";
    println!( "{}", got );
    assert_eq!( got, exp );

    // derived FromStr
    use std::str::FromStr;
    let src = Struct1::from_str( "1-3" );
    let exp = Ok( Struct1 { a : 1, b : 3 } );
    assert_eq!( src, exp );
  }
}
