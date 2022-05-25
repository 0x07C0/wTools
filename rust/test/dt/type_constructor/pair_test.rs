#[ allow( unused_imports ) ]
use super::TheModule;
use test_tools::*;
use TheModule::*;

tests_impls!
{

  #[ test ]
  fn basic_test()
  {
    use core::fmt;

    mod mod1
    {
      pub use f32;
      pub use f64;
    }

    trait Round { fn round( &self ) -> Self; };
    impl Round for ( f32, f64 )
    {
      fn round( &self ) -> Self
      {
        dbg!( &self );
        ( self.0.round(), self.1.round() )
      }
    }

    // trace_macros!( true );
    types!
    {

      ///
      /// Attribute which is inner.
      ///

      #[ derive( Debug, Clone ) ]
      #[ derive( PartialEq ) ]
      pair Pair : mod1::f32, mod1::f64;

    }
    // trace_macros!( false );

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair = ( 13.0, 31.0 ).into();
    let instance2 = Pair::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );
    assert!( implements!( instance1 => PartialEq ) );
    assert!( implements!( instance1 => Clone ) );
    assert!( implements!( instance1 => fmt::Debug ) );
    assert!( !implements!( instance1 => Default ) );

    /* test.case( "from pair / into tuple" ) */
    let instance1 : ( _, _ ) = ( Pair::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = < ( _, _ ) >::from( Pair::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from itself / into itself" ) */
    let instance1 : Pair = ( Pair::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = Pair::from( Pair::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair = ( 13.0, 31.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    // /* test.case( "deref" ) */
    // let got : Pair = ( 13.5, 31.5 ).into();
    // assert_eq!( got.round(), ( 14.0, 32.0 ) );

  }

  //

  #[ test ]
  fn empty_parameter_test()
  {

    mod mod1
    {
      pub use f32;
      pub use f64;
    }

    trait Round { fn round( &self ) -> Self; };
    impl Round for ( f32, f64 )
    {
      fn round( &self ) -> Self
      {
        dbg!( &self );
        ( self.0.round(), self.1.round() )
      }
    }

    // trace_macros!( true );
    types!
    {

      ///
      /// Attribute which is inner.
      ///

      #[ derive( Debug, Clone ) ]
      #[ derive( PartialEq ) ]
      pair Pair : mod1::f32<>, mod1::f64<>;

    }
    // trace_macros!( false );

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair = ( 13.0, 31.0 ).into();
    let instance2 = Pair::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from itself / into itself" ) */
    let instance1 : Pair = ( Pair::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = Pair::from( Pair::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair = ( 13.0, 31.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

  }

  //

  #[ test ]
  fn parametrized_multiple_test()
  {

    macro_rules! mk1
    {
      (
        $( $Rest : tt )*
      )
      =>
      {
        mod1::Floats::from( $( $Rest )* )
      };
    }

    macro_rules! mk2
    {
      (
        $( $Rest : tt )*
      )
      =>
      {
        std::sync::Arc::new( $( $Rest )* )
      };
    }

    macro_rules! mk
    {
      (
        $( $Rest : tt )*
      )
      =>
      {
        (
          mk1!( $( $Rest )* ),
          mk2!( 31.0 ),
        )
      };
    }

    mod mod1
    {

      #[ derive( Debug, Clone, PartialEq ) ]
      pub struct Floats< T1 : PartialEq + Copy, T2 : Default >
      (
        pub T1,
        pub T2,
      );

      impl< T1 : PartialEq + Copy, T2 : Default > core::ops::Deref
      for Floats< T1, T2 >
      {
        type Target = T1;
        fn deref( &self ) -> &Self::Target
        {
          &self.0
        }
      }

      impl< T1 : PartialEq + Copy, T2 : Default > From< T1 >
      for Floats< T1, T2 >
      {
        fn from( src : T1 ) -> Self
        {
          Floats::< T1, T2 >( src, T2::default() )
        }
      }

    }

    // trace_macros!( true );
    types!
    {
      #[ derive( Debug, Clone ) ]
      #[ derive( PartialEq ) ]
      pair Pair :
        mod1::Floats< T1 : PartialEq + std::marker::Copy, T2 : Default >,
        std::sync::Arc< T : Copy >,
      ;

    }
    // trace_macros!( false );

    /* test.case( "make2" ) */
    let got : Pair< f32, f64, f32 > = make!( mk1!( 13.0 ), mk2!( 31.0 ) );
    let exp = Pair::< f32, f64, f32 >( mk1!( 13.0 ), mk2!( 31.0 ) );
    assert_eq!( got, exp );

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair< f32, f64, f32 > = mk!( 13.0 ).into();
    let instance2 = Pair::< f32, f64, f32 >::from( mk!( 13.0 ) );
    assert_eq!( instance1.0.0, 13.0 );
    assert_eq!( instance2.0.0, 13.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from Pair / into tuple" ) */
    let instance1 : Pair< f32, f64, f32 > = mk!( 13.0 ).into();
    let got : ( mod1::Floats< f32, f64 >, _ ) = instance1.into();
    assert_eq!( got.0.0, 13.0 );
    let instance1 : Pair< f32, f64, f32 > = mk!( 13.0 ).into();
    let got = < ( mod1::Floats::< f32, f64 >, _ ) >::from( instance1 );
    assert_eq!( got.0.0, 13.0 );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair< f32, f64, f32 > = mk!( 13.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance2.0, mk1!( 13.0 ) );
    assert_eq!( instance1, instance2 );


  }

  //

  #[ test ]
  fn parametrized_mixed_test()
  {

    /* test.case( "control case" ) */
    {

      // trace_macros!( true );
      types!
      {

        ///
        /// Attribute which is inner.
        ///

        #[ derive( Debug, Clone ) ]
        #[ derive( PartialEq ) ]
        pair Pair :
          std::sync::Arc< T : Copy >,
          f32<>,
        ;

      }
      // trace_macros!( false );

      let instance1 : Pair< f64 > =
      (
        std::sync::Arc::new( 13.0 ),
        31.0,
      ).into();
      let instance2 = Pair::< f64 >::from
      ((
        std::sync::Arc::new( 13.0 ),
        31.0,
      ));
      assert_eq!( instance1, instance2 );

    }

    /* test.case( "second without <> with comma" ) */
    {

      // trace_macros!( true );
      types!
      {

        ///
        /// Attribute which is inner.
        ///

        #[ derive( Debug, Clone ) ]
        #[ derive( PartialEq ) ]
        pair Pair :
          std::sync::Arc< T : Copy >,
          f32,
        ;

      }
      // trace_macros!( false );

      let instance1 : Pair< f64 > =
      (
        std::sync::Arc::new( 13.0 ),
        31.0,
      ).into();
      let instance2 = Pair::< f64 >::from
      ((
        std::sync::Arc::new( 13.0 ),
        31.0,
      ));
      assert_eq!( instance1, instance2 );

    }

    /* test.case( "second without <> without comma" ) */
    {

      // trace_macros!( true );
      types!
      {

        ///
        /// Attribute which is inner.
        ///

        #[ derive( Debug, Clone ) ]
        #[ derive( PartialEq ) ]
        pair Pair :
          std::sync::Arc< T : Copy >,
          f32
        ;

      }
      // trace_macros!( false );

      let instance1 : Pair< f64 > =
      (
        std::sync::Arc::new( 13.0 ),
        31.0,
      ).into();
      let instance2 = Pair::< f64 >::from
      ((
        std::sync::Arc::new( 13.0 ),
        31.0,
      ));
      assert_eq!( instance1, instance2 );

    }

    /* test.case( "first without <> with comma" ) */
    {

      // trace_macros!( true );
      types!
      {

        ///
        /// Attribute which is inner.
        ///

        #[ derive( Debug, Clone ) ]
        #[ derive( PartialEq ) ]
        pair Pair :
          f32,
          std::sync::Arc< T : Copy >,
        ;

      }
      // trace_macros!( false );

      let instance1 : Pair< f64 > =
      (
        31.0,
        std::sync::Arc::new( 13.0 ),
      ).into();
      let instance2 = Pair::< f64 >::from
      ((
        31.0,
        std::sync::Arc::new( 13.0 ),
      ));
      assert_eq!( instance1, instance2 );

    }

    /* test.case( "first without <> without comma" ) */
    {

      // trace_macros!( true );
      types!
      {

        ///
        /// Attribute which is inner.
        ///

        #[ derive( Debug, Clone ) ]
        #[ derive( PartialEq ) ]
        pair Pair :
          f32,
          std::sync::Arc< T : Copy >
        ;

      }
      // trace_macros!( false );

      let instance1 : Pair< f64 > =
      (
        31.0,
        std::sync::Arc::new( 13.0 ),
      ).into();
      let instance2 = Pair::< f64 >::from
      ((
        31.0,
        std::sync::Arc::new( 13.0 ),
      ));
      assert_eq!( instance1, instance2 );

    }

  }

  //

  #[ test ]
  fn parametrized_no_derives_test()
  {

    mod mod1
    {
      pub struct Floats< T1, T2 >
      (
        pub T1,
        pub T2,
      );
    }

    // trace_macros!( true );
    types!
    {
      pair Pair : mod1::Floats< T1, T2 >, mod1::Floats< T3, T4 >;
    }
    // trace_macros!( false );

    let instance1 : Pair< f32, f64, f32, f64 >;

  }

  //

  #[ test ]
  fn parameter_complex_test()
  {
    use core::fmt;

    types!
    {
      #[ derive( Debug, Clone ) ]
      #[ derive( PartialEq ) ]
      pair Pair : < T1 : core::cmp::PartialEq + core::clone::Clone, T2 : core::cmp::PartialEq + core::clone::Clone >;
    }

    /* test.case( "traits" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    assert!( implements!( instance1 => PartialEq ) );
    assert!( implements!( instance1 => Clone ) );
    assert!( implements!( instance1 => fmt::Debug ) );
    assert!( !implements!( instance1 => Default ) );
    assert!( !implements!( instance1 => fmt::Display ) );

    /* test.case( "make0" ) */
    let got : Pair< f32, f64 > = make!();
    let exp = Pair::< f32, f64 >( 0.0, 0.0 );
    assert_eq!( got, exp );

    /* test.case( "make2" ) */
    let got : Pair< f32, f64 > = make!( 13.0, 31.0 );
    let exp = Pair::< f32, f64 >( 13.0, 31.0 );
    assert_eq!( got, exp );

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = Pair::< f32, f64 >::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from Pair / into tuple" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = Pair::< f32, f64 >::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from itself / into itself" ) */
    let instance1 : Pair< f32, f64 > = ( Pair::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = Pair::< f32, f64 >::from( Pair::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

//     /* test.case( "deref" ) */
//     let got : Pair< f32, f64 > = ( 13.5 ).into();
//     assert_eq!( got.round(), 14.0 );

  }

  //

  #[ test ]
  fn parameter_no_derives_test()
  {

    mod mod1
    {
      pub struct Floats< T1, T2 >
      (
        pub T1,
        pub T2,
      );
    }

    // trace_macros!( true );
    types!
    {
      pair Pair : < T1, T2 >;
    }
    // trace_macros!( false );

    /* test.case( "smoke test" ) */
    let instance1 = Pair( mod1::Floats( 13.0, 31.0 ), mod1::Floats( 13.0, 31.0 ) );

  }

  //

  #[ test ]
  fn multiple_test()
  {
    use core::fmt;

    types!
    {

      pair Pair1 : f64, f32;

      #[ derive( Debug ) ]
      #[ derive( PartialEq, Clone ) ]
      pair Pair2 : f32, f64;

    }

    /* test.case( "from tuple / into Pair2" ) */
    let instance1 : Pair1 = ( 13.0, 31.0 ).into();
    let instance2 = Pair1::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance2.0, 13.0 );
    assert!( !implements!( instance1 => PartialEq ) );
    assert!( !implements!( instance1 => Clone ) );
    assert!( !implements!( instance1 => fmt::Debug ) );
    assert!( !implements!( instance1 => Default ) );

    /* test.case( "from tuple / into Pair2" ) */
    let instance1 : Pair2 = ( 13.0, 31.0 ).into();
    let instance2 = Pair2::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance1, instance2 );
    assert!( implements!( instance1 => PartialEq ) );
    assert!( implements!( instance1 => Clone ) );
    assert!( implements!( instance1 => fmt::Debug ) );
    assert!( !implements!( instance1 => Default ) );

    /* test.case( "from tuple / into Pair2" ) */
    let instance1 : Pair2 = ( 13.0, 31.0 ).into();
    let instance2 = Pair2::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from itself / into itself" ) */
    let instance1 : Pair2 = ( Pair2::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = Pair2::from( Pair2::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from Pair2 / into tuple" ) */
    let instance1 : Pair2 = ( 13.0, 31.0 ).into();
    let got : ( _, _ ) = instance1.into();
    assert_eq!( got, ( 13.0, 31.0 ) );
    let instance1 : Pair2 = ( 13.0, 31.0 ).into();
    let got = <( f32, f64 )>::from( instance1 );
    assert_eq!( got, ( 13.0, 31.0 ) );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair2 = ( 13.0, 31.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance1, instance2 );

    // /* test.case( "deref" ) */
    // let got : Pair2 = ( 13.5, 15.5 ).into();
    // assert_eq!( got.round(), 14.0 );

  }

  //

  #[ test ]
  fn struct_basic_test()
  {

    /* test.case( "make0" ) */
    let got : Pair< f32, f64 > = make!();
    let exp = Pair::< f32, f64 >( 0.0, 0.0 );
    assert_eq!( got, exp );

    /* test.case( "make2" ) */
    let got : Pair< f32, f64 > = make!( 13.0, 31.0 );
    let exp = Pair::< f32, f64 >( 13.0, 31.0 );
    assert_eq!( got, exp );

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = Pair::< f32, f64 >::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from Pair / into tuple" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = Pair::< f32, f64 >::from( ( 13.0, 31.0 ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "from itself / into itself" ) */
    let instance1 : Pair< f32, f64 > = ( Pair::from( ( 13.0, 31.0 ) ) ).into();
    let instance2 = Pair::< f32, f64 >::from( Pair::from( ( 13.0, 31.0 ) ) );
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "clone / eq" ) */
    let instance1 : Pair< f32, f64 > = ( 13.0, 31.0 ).into();
    let instance2 = instance1.clone();
    assert_eq!( instance1.0, 13.0 );
    assert_eq!( instance1.1, 31.0 );
    assert_eq!( instance2.0, 13.0 );
    assert_eq!( instance2.1, 31.0 );
    assert_eq!( instance1, instance2 );

    /* test.case( "default" ) */
    let instance1 : Pair< f32, f64 > = Default::default();
    assert_eq!( instance1.0, 0.0 );
    assert_eq!( instance1.1, 0.0 );

//     /* test.case( "deref" ) */
//     let got : Pair< f32, f64 > = ( 13.5 ).into();
//     assert_eq!( got.round(), 14.0 );

  }

  //

  #[ test ]
  fn struct_no_derives_test()
  {

    struct Floats< T1, T2 >( pub T1, pub T2 );

    impl< T1, T2 > Floats< T1, T2 >
    {
      pub fn new( src : ( T1, T2 ) ) -> Self
      { Self( src.0, src.1 ) }
    }

    /* test.case( "from tuple / into pair" ) */
    let instance1 : Pair< Floats< f32, f64 >, f32 > = ( Floats( 13.0, 31.0 ), 131.0 ).into();
    let instance2 = Pair::< Floats< f32, f64 >, f32 >::from( ( Floats( 13.0, 31.0 ), 131.0 ) );
    assert_eq!( instance1.0.0, 13.0 );
    assert_eq!( instance1.0.1, 31.0 );
    assert_eq!( instance1.1, 131.0 );
    assert_eq!( instance2.0.0, 13.0 );
    assert_eq!( instance2.0.1, 31.0 );
    assert_eq!( instance2.1, 131.0 );

  }

  //

  #[ test ]
  fn samples_test()
  {

    /* test.case( "single-line" ) */
    {
      types!( pair MyPair : i32, i64 );
      let x = MyPair( 13, 31 );
      println!( "x : ( {}, {} )", x.0, x.1 );
      // prints : x : ( 13, 31 )
    }

    /* test.case( "parametrized tuple" ) */
    {
      use core::fmt;
      types!
      {
        #[ derive( Debug ) ]
        pair MyPair : < T1 : fmt::Debug, T2 : fmt::Debug >;
      }
      let x = MyPair( 13, 13.0 );
      dbg!( x );
      // prints : x = MyPair( 13, 13.0 )
    }

  }

}

//

tests_index!
{

  basic_test,
  empty_parameter_test,
  parametrized_multiple_test,
  parametrized_mixed_test,
  parametrized_no_derives_test,
  parameter_complex_test,
  parameter_no_derives_test,
  multiple_test,
  struct_basic_test,
  struct_no_derives_test,
  samples_test,

}