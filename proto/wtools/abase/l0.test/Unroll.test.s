( function _Unroll_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer1.s' );
  _.include( 'wTesting' );
}

let _ = _global_.wTools;

// --
// unroll
// --

function unrollIs( test )
{
  test.case = 'unroll from empty array';

  var src = [];
  var got = _.unrollMake( src );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'unroll from not empty array';

  var src = [ 1 ];
  var got = _.unrollMake( src );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  var src = [ 'str' ];
  var got = _.unrollFrom( src );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'not unroll';

  var got = new F32x( [ 3, 1, 2 ] );
  test.identical( _.unrollIs( got ), false );

  test.identical( _.unrollIs( [] ), false );

  test.identical( _.unrollIs( 1 ), false );

  test.identical( _.unrollIs( 'str' ), false );

  test.case = 'second argument is unroll';

  var got = _.unrollMake( [ 2, 4 ] );
  test.identical( _.unrollIs( [ 1, 'str' ], got ), false );
  test.is( _.arrayIs( got ) );

  var got = _.unrollFrom( [ 2, 4 ] );
  test.identical( _.unrollIs( 1, got ), false );
  test.is( _.arrayIs( got ) );

  var got = _.unrollMake( [ 2, 4 ] );
  test.identical( _.unrollIs( 'str', got ), false );
  test.is( _.arrayIs( got ) );
}

//

function unrollIsPopulated( test )
{
  test.case = 'unroll from not empty array';

  var src = [ 1 ];
  var got = _.unrollMake( src );
  test.is( _.unrollIsPopulated( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  var src = [ 'str' ];
  var got = _.unrollFrom( src );
  test.is( _.unrollIsPopulated( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  var src = [ [] ];
  var got = _.unrollFrom( src );
  test.is( _.unrollIsPopulated( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  var src = [ null ];
  var got = _.unrollMake( src );
  test.is( _.unrollIsPopulated( got ) );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'unroll from empty array';
  var src = [];
  var got = _.unrollFrom( src );
  test.identical( _.unrollIsPopulated( got ), false );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'not unroll';

  var got = new F32x( [ 3, 1, 2 ] );
  test.identical( _.unrollIs( got ), false );

  test.identical( _.unrollIsPopulated( [] ), false );

  test.identical( _.unrollIsPopulated( 1 ), false );

  test.identical( _.unrollIsPopulated( 'str' ), false );

  test.case = 'second argument is unroll';

  var got = _.unrollMake( [ 2, 4 ] );
  test.identical( _.unrollIsPopulated( [ 1, 'str' ], got ), false );
  test.is( _.arrayIs( got ) );

  var got = _.unrollFrom( [ 2, 4 ] );
  test.identical( _.unrollIsPopulated( 1, got ), false );
  test.is( _.arrayIs( got ) );

  var got = _.unrollMake( [ 2, 4 ] );
  test.identical( _.unrollIsPopulated( 'str', got ), false );
  test.is( _.arrayIs( got ) );
}

//

function unrollMake( test )
{
  test.case = 'without arguments';
  var got = _.unrollMake();
  test.equivalent( got, [] );
  test.is( _.unrollIs( got ) );

  test.case = 'src - null';
  var got = _.unrollMake( null );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'src - undefined';
  var got = _.unrollMake( undefined );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'src - zero';
  var got = _.unrollMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( expected !== got );

  test.case = 'src - number > 0';
  var got = _.unrollMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( expected !== got );

  test.case = 'empty array';
  var src = [];
  var got = _.unrollMake( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, array.length - 1';
  var src = [ 0 ];
  var got = _.unrollMake( src );
  test.equivalent( got, [ 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, array.length > 1';
  var src = [ 1, 2, 3, 'str' ];
  var got = _.unrollMake( src );
  test.equivalent( got, [ 1, 2, 3, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from empty BufferTyped - F32x';
  var src = new F32x();
  var got = _.unrollMake( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from Float32 - U8x';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.unrollMake( src );
  test.equivalent( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollMake( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from arguments array';
  var src = _.argumentsArrayMake( 3 );
  var got = _.unrollMake( src );
  test.equivalent( got, [ undefined, undefined, undefined ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from empty unroll';
  var src = _.unrollMake( [] );
  var got = _.unrollMake( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'from unroll';
  var src = _.unrollMake( [ 1, 2, 3, 'str' ] );
  var got = _.unrollMake( src );
  test.equivalent( got, [ 1, 2, 3, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.unrollMake( 1, 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.unrollMake( {} ) );
  test.shouldThrowErrorSync( () => _.unrollMake( 'wrong' ) );
}

//

function unrollMakeLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'without arguments';
    var got = descriptor.unrollMake();
    test.equivalent( got, [] );
    test.is( _.unrollIs( got ) );

    test.case = 'src - null';
    var got = descriptor.unrollMake( null );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );

    test.case = 'src - undefined';
    var got = descriptor.unrollMake( undefined );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );

    test.case = 'src - zero';
    var got = descriptor.unrollMake( 0 );
    var expected = new Array( 0 );
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( expected !== got );

    test.case = 'src - number > 0';
    var got = descriptor.unrollMake( 3 );
    var expected = new Array( 3 );
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( expected !== got );

    test.case = 'empty array';
    var src = [];
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, array.length - 1';
    var src = [ 0 ];
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [ 0 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, array.length > 1';
    var src = [ 1, 2, 3, 'str' ];
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [ 1, 2, 3, 'str' ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from empty BufferTyped - F32x';
    var src = new F32x();
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from Float32 - U8x';
    var src = new U8x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [ 1, 2, 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from empty arguments array';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from arguments array';
    var src = _.argumentsArrayMake( 3 );
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [ undefined, undefined, undefined ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from empty unroll';
    var src = descriptor.unrollMake( [] );
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'from unroll';
    var src = descriptor.unrollMake( [ 1, 2, 3, 'str' ] );
    var got = descriptor.unrollMake( src );
    test.equivalent( got, [ 1, 2, 3, 'str' ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollMake( 1, 'extra' ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.unrollMake( {} ) );
      test.shouldThrowErrorSync( () => descriptor.unrollMake( 'wrong' ) );
    }
  }
}

//

function unrollMakeUndefined( test )
{
  test.case = 'without arguments';
  var got = _.unrollMakeUndefined();
  var expected = _.unrollMake();
  test.identical( got, expected );

  test.case = 'src - null';
  var src = null;
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - null, length - null';
  var src = null;
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - null, length - undefined';
  var src = null;
  var got = _.unrollMakeUndefined( src, undefined );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - null, length - number';
  var src = null;
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - null, length - long';
  var src = null;
  var got = _.unrollMakeUndefined( src, new U8x( 4 ) );
  var expected = _.unrollMake( 4 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - number';
  var src = 5;
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 5 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - number, length - null';
  var src = 5;
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 5 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - null, length - undefined';
  var src = 5;
  var got = _.unrollMakeUndefined( src, undefined );
  var expected = _.unrollMake( 5 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty array, length - null';
  var src = [];
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty array, length - 2';
  var src = [];
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, src.length - 1';
  var src = [ 0 ];
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, src.length - 1, length - 2';
  var src = [ 0 ];
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, src.length > 1';
  var src = [ 1, 2, 3 ];
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array, src.length > 1, length < src.length';
  var src = [ 1, 2, 3 ];
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty U8x';
  var src = new U8x();
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty U8x, length - null';
  var src = new U8x();
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty U8x, length - 2';
  var src = new U8x();
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - U8x, src.length - 1';
  var src = new U8x( 1 );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - U8x, src.length - 1, length > src.length';
  var src = new U8x( 1 );
  var got = _.unrollMakeUndefined( src, 3 );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - U8x, src.length > 1';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - U8x, src.length > 1, length < src.length';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src, 0 );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty I16x';
  var src = new I16x();
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty I16x, length - null';
  var src = new I16x();
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty I16x, length - 2';
  var src = new I16x();
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - I16x, src.length - 1';
  var src = new I16x( 1 );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - I16x, src.length - 1, length > src.length';
  var src = new I16x( 1 );
  var got = _.unrollMakeUndefined( src, 3 );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - I16x, src.length > 1';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - I16x, src.length > 1, length < src.length';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src, 0 );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty F32x';
  var src = new F32x();
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty F32x, length - null';
  var src = new F32x();
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty F32x, length - 2';
  var src = new F32x();
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - F32x, src.length - 1';
  var src = new F32x( 1 );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - F32x, src.length - 1, length > src.length';
  var src = new F32x( 1 );
  var got = _.unrollMakeUndefined( src, 3 );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - F32x, src.length > 1';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - F32x, src.length > 1, length < src.length';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src, 0 );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty arguments array, length - null';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty arguments array, length - number > 0';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - arguments array, src.length - 1';
  var src = _.argumentsArrayMake( [ {} ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - arguments array, src.length - 1, length > src.length';
  var src = _.argumentsArrayMake( [ {} ] );
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - arguments array, src.length > 1';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - arguments array, src.length > 1, length < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src, 1 );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty unroll';
  var src = _.unrollMake( [] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( [] );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty unroll, length - null';
  var src = _.unrollMake( [] );
  var got = _.unrollMakeUndefined( src, null );
  var expected = _.unrollMake( 0 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty unroll, length - 2';
  var src = _.unrollMake( [] );
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll, src.length - 1';
  var src = _.unrollMake( [ 'str' ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll, src.length - 1, length > src.length';
  var src = _.unrollMake( [ 'str' ] );
  var got = _.unrollMakeUndefined( src, 2 );
  var expected = _.unrollMake( 2 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll, src.length > 1';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src );
  var expected = _.unrollMake( 3 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll, src.length > 1, length < src.length';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.unrollMakeUndefined( src, 1 );
  var expected = _.unrollMake( 1 );
  test.equivalent( got, expected );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( 1, 3, 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( {} ) );
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( 'wrong' ) );

  test.case = 'wrong length';
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( [], Infinity ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( [], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.unrollMakeUndefined( [], {} ) );
}

//

function unrollMakeUndefinedLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'without arguments';
    var got = _.unrollMakeUndefined();
    var expected = _.unrollMake();
    test.identical( got, expected );

    test.case = 'src - null';
    var src = null;
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - null, length - null';
    var src = null;
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - null, length - undefined';
    var src = null;
    var got = descriptor.unrollMakeUndefined( src, undefined );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - null, length - number';
    var src = null;
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - null, length - long';
    var src = null;
    var got = descriptor.unrollMakeUndefined( src, new U8x( 4 ) );
    var expected = _.unrollMake( 4 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - number';
    var src = 5;
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 5 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - number, length - null';
    var src = 5;
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 5 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - null, length - undefined';
    var src = 5;
    var got = descriptor.unrollMakeUndefined( src, undefined );
    var expected = _.unrollMake( 5 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty array';
    var src = [];
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty array, length - null';
    var src = [];
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty array, length - 2';
    var src = [];
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, src.length - 1';
    var src = [ 0 ];
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, src.length - 1, length - 2';
    var src = [ 0 ];
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, src.length > 1';
    var src = [ 1, 2, 3 ];
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array, src.length > 1, length < src.length';
    var src = [ 1, 2, 3 ];
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty U8x';
    var src = new U8x();
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty U8x, length - null';
    var src = new U8x();
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty U8x, length - 2';
    var src = new U8x();
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - U8x, src.length - 1';
    var src = new U8x( 1 );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - U8x, src.length - 1, length > src.length';
    var src = new U8x( 1 );
    var got = descriptor.unrollMakeUndefined( src, 3 );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - U8x, src.length > 1';
    var src = new U8x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - U8x, src.length > 1, length < src.length';
    var src = new U8x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src, 0 );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty I16x';
    var src = new I16x();
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty I16x, length - null';
    var src = new I16x();
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty I16x, length - 2';
    var src = new I16x();
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - I16x, src.length - 1';
    var src = new I16x( 1 );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - I16x, src.length - 1, length > src.length';
    var src = new I16x( 1 );
    var got = descriptor.unrollMakeUndefined( src, 3 );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - I16x, src.length > 1';
    var src = new I16x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - I16x, src.length > 1, length < src.length';
    var src = new I16x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src, 0 );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty F32x';
    var src = new F32x();
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty F32x, length - null';
    var src = new F32x();
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty F32x, length - 2';
    var src = new F32x();
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - F32x, src.length - 1';
    var src = new F32x( 1 );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - F32x, src.length - 1, length > src.length';
    var src = new F32x( 1 );
    var got = descriptor.unrollMakeUndefined( src, 3 );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - F32x, src.length > 1';
    var src = new F32x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - F32x, src.length > 1, length < src.length';
    var src = new F32x( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src, 0 );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty arguments array';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty arguments array, length - null';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty arguments array, length - number > 0';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - arguments array, src.length - 1';
    var src = _.argumentsArrayMake( [ {} ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - arguments array, src.length - 1, length > src.length';
    var src = _.argumentsArrayMake( [ {} ] );
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - arguments array, src.length > 1';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    test.case = 'src - arguments array, src.length > 1, length < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src, 1 );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( !_.argumentsArrayIs( got ) );
    test.is( src !== got );

    /* */

    test.case = 'src - empty unroll';
    var src = _.unrollMake( [] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( [] );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty unroll, length - null';
    var src = _.unrollMake( [] );
    var got = descriptor.unrollMakeUndefined( src, null );
    var expected = _.unrollMake( 0 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty unroll, length - 2';
    var src = _.unrollMake( [] );
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - unroll, src.length - 1';
    var src = _.unrollMake( [ 'str' ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - unroll, src.length - 1, length > src.length';
    var src = _.unrollMake( [ 'str' ] );
    var got = descriptor.unrollMakeUndefined( src, 2 );
    var expected = _.unrollMake( 2 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - unroll, src.length > 1';
    var src = _.unrollMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src );
    var expected = _.unrollMake( 3 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - unroll, src.length > 1, length < src.length';
    var src = _.unrollMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollMakeUndefined( src, 1 );
    var expected = _.unrollMake( 1 );
    test.equivalent( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( 1, 3, 'extra' ) );

      test.case = 'wrong length';
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( [], Infinity ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( {} ) );
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( 'wrong' ) );

      test.case = 'wrong type of length';
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( [], 'wrong' ) );
      test.shouldThrowErrorSync( () => descriptor.unrollMakeUndefined( [], {} ) );
    }
  }
}

//

/* aaa : split all groups of test cases by / * - * / for all test routines */
/* Dmytro : separate groups has delimeters */

/*aaa : test routine unrollFrom is poor */
/* Dmytro : test routine is extended */

function unrollFrom( test )
{
  test.case = 'src - null';
  var got = _.unrollFrom( null );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'src - undefined';
  var got = _.unrollFrom( undefined );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'src - zero';
  var got = _.unrollFrom( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( expected !== got );

  test.case = 'src - number > 0';
  var got = _.unrollFrom( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( expected !== got );

  test.case = 'src - empty unroll';
  var src = _.unrollMake( 0 );
  var got = _.unrollFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( got === src );

  test.case = 'src - unroll, src.length > 0';
  var src = _.unrollMake( 2 );
  var got = _.unrollFrom( src );
  test.identical( got, [ undefined, undefined ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( got === src );

  test.case = 'src - filled unroll';
  var src = _.unrollMake( [ 1, 'str', 3 ] );
  var got = _.unrollFrom( src );
  test.identical( got, [ 1, 'str', 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( got === src );

  test.case = 'src - empty array';
  var src = [];
  var got = _.unrollFrom( src );
  test.equivalent( got, src );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - array with single element';
  var src = [ 0 ];
  var got = _.unrollFrom( src );
  test.equivalent( got, src );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - arrray with several elements';
  var src = [ 1, 2, 'str' ];
  var got = _.unrollFrom( src );
  test.equivalent( got, src );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty BufferTyped - F32x';
  test.case = 'from F32x';
  var src = new F32x();
  var got = _.unrollFrom( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - filled BufferTyped - I16x';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.unrollFrom( src );
  test.equivalent( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollFrom( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - filled argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollFrom( src );
  test.equivalent( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.unrollFrom() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.unrollFrom( 1, 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.unrollFrom( {} ) );
  test.shouldThrowErrorSync( () => _.unrollFrom( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.unrollFrom( -1 ) );
}

//

function unrollFromLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'src - null';
    var got = descriptor.unrollFrom( null );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );

    test.case = 'src - undefined';
    var got = descriptor.unrollFrom( undefined );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );

    test.case = 'src - zero';
    var got = descriptor.unrollFrom( 0 );
    var expected = new Array( 0 );
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( expected !== got );

    test.case = 'src - number > 0';
    var got = descriptor.unrollFrom( 3 );
    var expected = new Array( 3 );
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( expected !== got );

    test.case = 'src - empty unroll';
    var src = _.unrollMake( 0 );
    var got = descriptor.unrollFrom( src );
    test.identical( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( got === src );

    test.case = 'src - unroll, src.length > 0';
    var src = _.unrollMake( 2 );
    var got = descriptor.unrollFrom( src );
    test.identical( got, [ undefined, undefined ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( got === src );

    test.case = 'src - filled unroll';
    var src = _.unrollMake( [ 1, 'str', 3 ] );
    var got = descriptor.unrollFrom( src );
    test.identical( got, [ 1, 'str', 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( got === src );

    test.case = 'src - empty array';
    var src = [];
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, src );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - array with single element';
    var src = [ 0 ];
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, src );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - arrray with several elements';
    var src = [ 1, 2, 'str' ];
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, src );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty BufferTyped - F32x';
    test.case = 'from F32x';
    var src = new F32x();
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - filled BufferTyped - I16x';
    var src = new I16x( [ 1, 2, 3 ] );
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, [ 1, 2, 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty argumentsArray';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - filled argumentsArray';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollFrom( src );
    test.equivalent( got, [ 1, 2, 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollFrom() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollFrom( 1, 3 ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.unrollFrom( {} ) );
      test.shouldThrowErrorSync( () => descriptor.unrollFrom( 'wrong' ) );
      test.shouldThrowErrorSync( () => descriptor.unrollFrom( -1 ) );
    }
  }
}

//

function unrollsFrom( test )
{
  test.case = 'srcs - null';
  var got = _.unrollsFrom( null );
  test.equivalent( got, [ [] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );

  test.case = 'srcs - undefined';
  var got = _.unrollsFrom( undefined );
  test.equivalent( got, [ [] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );

  test.case = 'srcs - several arguments';
  var got = _.unrollsFrom( 1, [], null, [ 1, { a : 2 } ] );
  var expected = [ [ undefined ], [], [], [ 1, { a : 2 } ] ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( _.unrollIs( got[ 3 ] ) );
  test.is( got !== expected );

  test.case = 'srcs - empty unroll';
  var src = _.unrollMake( 0 );
  var got = _.unrollsFrom( src );
  test.identical( got, [ [] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( got !== [ [] ] );

  test.case = 'srcs - filled unroll';
  var src = _.unrollMake( [ 1, 'str', 3 ] );
  var got = _.unrollsFrom( src );
  test.identical( got, [ [ 1, 'str', 3 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( got !== [ [ 1, 'str', 3 ] ] );

  test.case = 'srcs - several arguments with unroll';
  var src = _.unrollMake( [ 1, 'str', 3 ] );
  var got = _.unrollsFrom( 1, [], src );
  var expected = [ [ undefined ], [], [ 1, 'str', 3 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( _.unrollIs( got[ 2 ] ) );
  test.is( got !== expected );

  test.case = 'srcs - empty F32x buffer';
  var src = new F32x();
  var got = _.unrollsFrom( src );
  test.equivalent( got, [ [] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( [ src ] !== got );

  test.case = 'srcs - filled U8x buffer';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.unrollsFrom( src );
  test.equivalent( got, [ [ 1, 2, 3 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( [ src ] !== got );

  test.case = 'srcs - several arguments with I16x buffer';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.unrollsFrom( [], 1, src );
  test.equivalent( got, [ [], [ undefined ], [ 1, 2, 3 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( _.unrollIs( got[ 1 ] ) );
  test.is( _.unrollIs( got[ 2 ] ) );
  test.is( [ src ] !== got );

  test.case = 'srcs - empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollsFrom( src );
  test.equivalent( got, [ [] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( [ src ] !== got );

  test.case = 'srcs - filled arguments array';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollsFrom( src );
  test.equivalent( got, [ [ 1, 2, 3 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( [ src ] !== got );

  test.case = 'srcs - several arguments with arguments array';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollsFrom( [], 1, src );
  test.equivalent( got, [ [], [ undefined ], [ 1, 2, 3 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( _.unrollIs( got[ 0 ] ) );
  test.is( _.unrollIs( got[ 1 ] ) );
  test.is( _.unrollIs( got[ 2 ] ) );
  test.is( [ src ] !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.unrollsFrom() );

  test.case = 'argument is not array, not null';
  test.shouldThrowErrorSync( () => _.unrollsFrom( {} ) );
  test.shouldThrowErrorSync( () => _.unrollsFrom( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.unrollsFrom( 2, {} ) );
  test.shouldThrowErrorSync( () => _.unrollsFrom( [ '1' ], [ 1, 'str' ], 'abc' ) );
}

//

function unrollsFromLongDescriptor( test )
{
   let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'srcs - null';
    var got = descriptor.unrollsFrom( null );
    test.equivalent( got, [ [] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );

    test.case = 'srcs - undefined';
    var got = descriptor.unrollsFrom( undefined );
    test.equivalent( got, [ [] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );

    test.case = 'srcs - several arguments';
    var got = descriptor.unrollsFrom( 1, [], null, [ 1, { a : 2 } ] );
    var expected = [ [ undefined ], [], [], [ 1, { a : 2 } ] ];
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( _.unrollIs( got[ 3 ] ) );
    test.is( got !== expected );

    test.case = 'srcs - empty unroll';
    var src = _.unrollMake( 0 );
    var got = descriptor.unrollsFrom( src );
    test.identical( got, [ [] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( got !== [ [] ] );

    test.case = 'srcs - filled unroll';
    var src = _.unrollMake( [ 1, 'str', 3 ] );
    var got = descriptor.unrollsFrom( src );
    test.identical( got, [ [ 1, 'str', 3 ] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( got !== [ [ 1, 'str', 3 ] ] );

    test.case = 'srcs - several arguments with unroll';
    var src = _.unrollMake( [ 1, 'str', 3 ] );
    var got = descriptor.unrollsFrom( 1, [], src );
    var expected = [ [ undefined ], [], [ 1, 'str', 3 ] ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( _.unrollIs( got[ 2 ] ) );
    test.is( got !== expected );

    test.case = 'srcs - empty F32x buffer';
    var src = new F32x();
    var got = descriptor.unrollsFrom( src );
    test.equivalent( got, [ [] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( [ src ] !== got );

    test.case = 'srcs - filled U8x buffer';
    var src = new U8x( [ 1, 2, 3 ] );
    var got = descriptor.unrollsFrom( src );
    test.equivalent( got, [ [ 1, 2, 3 ] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( [ src ] !== got );

    test.case = 'srcs - several arguments with I16x buffer';
    var src = new I16x( [ 1, 2, 3 ] );
    var got = descriptor.unrollsFrom( [], 1, src );
    test.equivalent( got, [ [], [ undefined ], [ 1, 2, 3 ] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( _.unrollIs( got[ 1 ] ) );
    test.is( _.unrollIs( got[ 2 ] ) );
    test.is( [ src ] !== got );

    test.case = 'srcs - empty arguments array';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollsFrom( src );
    test.equivalent( got, [ [] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( [ src ] !== got );

    test.case = 'srcs - filled arguments array';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollsFrom( src );
    test.equivalent( got, [ [ 1, 2, 3 ] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( [ src ] !== got );

    test.case = 'srcs - several arguments with arguments array';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollsFrom( [], 1, src );
    test.equivalent( got, [ [], [ undefined ], [ 1, 2, 3 ] ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( _.unrollIs( got[ 0 ] ) );
    test.is( _.unrollIs( got[ 1 ] ) );
    test.is( _.unrollIs( got[ 2 ] ) );
    test.is( [ src ] !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollsFrom() );

      test.case = 'argument is not array, not null';
      test.shouldThrowErrorSync( () => descriptor.unrollsFrom( {} ) );
      test.shouldThrowErrorSync( () => descriptor.unrollsFrom( 'wrong' ) );
      test.shouldThrowErrorSync( () => descriptor.unrollsFrom( 2, {} ) );
      test.shouldThrowErrorSync( () => descriptor.unrollsFrom( [ '1' ], [ 1, 'str' ], 'abc' ) );
    }
  }
}

//

function unrollFromMaybe( test )
{
  test.case = 'src - undefined';
  var got = _.unrollFromMaybe( undefined );
  test.identical( got, undefined );

  test.case = 'src - empty string';
  var got = _.unrollFromMaybe( '' );
  test.identical( got, '' );
  test.is( _.primitiveIs( got ) );

  test.case = 'src - string';
  var got = _.unrollFromMaybe( 'str' );
  test.identical( got, 'str' );
  test.is( _.primitiveIs( got ) );

  test.case = 'src - booleant - true';
  var got = _.unrollFromMaybe( true );
  test.identical( got, true );
  test.is( _.primitiveIs( got ) );

  test.case = 'src - booleant - false';
  var got = _.unrollFromMaybe( false );
  test.identical( got, false );
  test.is( _.primitiveIs( got ) );

  test.case = 'src - empty map';
  var got = _.unrollFromMaybe( {} );
  test.identical( got, {} );
  test.is( _.mapIs( got ) );

  test.case = 'src - filled map';
  var got = _.unrollFromMaybe( { a : 0, b : 'str' } );
  test.identical( got, { a : 0, b : 'str' } );
  test.is( _.mapIs( got ) );

  test.case = 'src - empty pure map';
  var got = _.unrollFromMaybe( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIs( got ) );

  test.case = 'src - filled map';
  var src = Object.create( null );
  src.a = 0;
  src.b = 'str'
  var got = _.unrollFromMaybe( src );
  test.identical( got, { a : 0, b : 'str' } );
  test.is( _.mapIs( got ) );

  test.case = 'src - empty HashMap';
  var src = new Map();
  var got = _.unrollFromMaybe( src );
  test.identical( got, new Map() );
  test.is( _.hashMapIs( got ) );

  test.case = 'src - filled HashMap';
  var src = new Map( [ [ 1, 2 ], [ 'a', 'b' ] ] );
  var got = _.unrollFromMaybe( src );
  test.identical( got, new Map( [ [ 1, 2 ], [ 'a', 'b' ] ] ) );
  test.is( _.hashMapIs( got ) );

  test.case = 'src - empty Set';
  var src = new Set( [] );
  var got = _.unrollFromMaybe( src );
  test.identical( got, new Set() );
  test.is( _.setIs( got ) );

  test.case = 'src - filled Set';
  var src = new Set( [ 1, 'abc' ] );
  var got = _.unrollFromMaybe( src );
  test.identical( got, new Set( [ 1, 'abc' ] ) );
  test.is( _.setIs( got ) );

  test.case = 'src - instance of constructor';
  function Constr(){ this.x = 1; return this };
  var src = new Constr();
  var got = _.unrollFromMaybe( src );
  test.identical( got, src );
  test.is( _.objectIs( got ) );

  test.case = 'src - null';
  var got = _.unrollFromMaybe( null );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( [] !== got );

  test.case = 'src - unroll';
  var src = _.unrollMake( 0 );
  var got = _.unrollFromMaybe( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( got !== [] );

  test.case = 'src - filled unroll';
  var src = _.unrollMake( [ 1, 'str', 3 ] );
  var got = _.unrollFromMaybe( src );
  test.identical( got, [ 1, 'str', 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( got !== [ 1, 'str', 3 ] );

  test.case = 'src - empty array';
  var src = [];
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, src );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - filled array';
  var src = [ 1, 2, 'str' ];
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, src );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - instance of Array constructor';
  var got = _.unrollFromMaybe( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( expected !== got );

  test.case = 'src - empty F32x buffer';
  var src = new F32x();
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - filled U8x buffer';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src - filled arguments array';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.unrollFromMaybe( src );
  test.equivalent( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.unrollFromMaybe() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.unrollFromMaybe( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.unrollFromMaybe( [], 3 ) );
  test.shouldThrowErrorSync( () => _.unrollFromMaybe( [], [] ) );
}

//

function unrollFromMaybeLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'src - undefined';
    var got = descriptor.unrollFromMaybe( undefined );
    test.identical( got, undefined );

    test.case = 'src - empty string';
    var got = descriptor.unrollFromMaybe( '' );
    test.identical( got, '' );
    test.is( _.primitiveIs( got ) );

    test.case = 'src - string';
    var got = descriptor.unrollFromMaybe( 'str' );
    test.identical( got, 'str' );
    test.is( _.primitiveIs( got ) );

    test.case = 'src - booleant - true';
    var got = descriptor.unrollFromMaybe( true );
    test.identical( got, true );
    test.is( _.primitiveIs( got ) );

    test.case = 'src - booleant - false';
    var got = descriptor.unrollFromMaybe( false );
    test.identical( got, false );
    test.is( _.primitiveIs( got ) );

    test.case = 'src - empty map';
    var got = descriptor.unrollFromMaybe( {} );
    test.identical( got, {} );
    test.is( _.mapIs( got ) );

    test.case = 'src - filled map';
    var got = descriptor.unrollFromMaybe( { a : 0, b : 'str' } );
    test.identical( got, { a : 0, b : 'str' } );
    test.is( _.mapIs( got ) );

    test.case = 'src - empty pure map';
    var got = descriptor.unrollFromMaybe( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIs( got ) );

    test.case = 'src - filled map';
    var src = Object.create( null );
    src.a = 0;
    src.b = 'str'
      var got = descriptor.unrollFromMaybe( src );
    test.identical( got, { a : 0, b : 'str' } );
    test.is( _.mapIs( got ) );

    test.case = 'src - empty HashMap';
    var src = new Map();
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, new Map() );
    test.is( _.hashMapIs( got ) );

    test.case = 'src - filled HashMap';
    var src = new Map( [ [ 1, 2 ], [ 'a', 'b' ] ] );
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, new Map( [ [ 1, 2 ], [ 'a', 'b' ] ] ) );
    test.is( _.hashMapIs( got ) );

    test.case = 'src - empty Set';
    var src = new Set( [] );
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, new Set() );
    test.is( _.setIs( got ) );

    test.case = 'src - filled Set';
    var src = new Set( [ 1, 'abc' ] );
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, new Set( [ 1, 'abc' ] ) );
    test.is( _.setIs( got ) );

    test.case = 'src - instance of constructor';
    function Constr1(){ this.x = 1; return this };
    var src = new Constr1();
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, src );
    test.is( _.objectIs( got ) );

    test.case = 'src - null';
    var got = descriptor.unrollFromMaybe( null );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( [] !== got );

    test.case = 'src - unroll';
    var src = _.unrollMake( 0 );
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( got !== [] );

    test.case = 'src - filled unroll';
    var src = _.unrollMake( [ 1, 'str', 3 ] );
    var got = descriptor.unrollFromMaybe( src );
    test.identical( got, [ 1, 'str', 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( got !== [ 1, 'str', 3 ] );

    test.case = 'src - empty array';
    var src = [];
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, src );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - filled array';
    var src = [ 1, 2, 'str' ];
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, src );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - instance of Array constructor';
    var got = descriptor.unrollFromMaybe( 3 );
    var expected = new Array( 3 );
    test.equivalent( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( expected !== got );

    test.case = 'src - empty F32x buffer';
    var src = new F32x();
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - filled U8x buffer';
    var src = new U8x( [ 1, 2, 3 ] );
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, [ 1, 2, 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - empty arguments array';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, [] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    test.case = 'src - filled arguments array';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.unrollFromMaybe( src );
    test.equivalent( got, [ 1, 2, 3 ] );
    test.is( _.arrayIs( got ) );
    test.is( _.unrollIs( got ) );
    test.is( src !== got );

    /* - */

    if( !Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollFromMaybe() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.unrollFromMaybe( 1, 3 ) );
      test.shouldThrowErrorSync( () => descriptor.unrollFromMaybe( [], 3 ) );
      test.shouldThrowErrorSync( () => descriptor.unrollFromMaybe( [], [] ) );
    }
  }
}

//

function unrollNormalize( test )
{
  test.case = 'dst is array';
  var got = _.unrollNormalize( [] );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var got = _.unrollNormalize( [ 1, 'str' ] );
  test.identical( got, [ 1, 'str' ] );
  test.is( _.arrayIs( got ) );

  test.case = 'dst is unroll';
  var got = _.unrollNormalize( _.unrollMake( [] ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var got = _.unrollNormalize( _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str' ] );
  test.is( _.arrayIs( got ) );

  test.case = 'dst is unroll from array';
  var src = new Array( 0 );
  var got = _.unrollNormalize( _.unrollFrom( src ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var src = new Array( [] );
  var got = _.unrollNormalize( _.unrollFrom( src ) );
  test.identical( got, [ [] ] );
  test.is( _.arrayIs( got ) );

  var src = new Array( [ 1, 2, 'str' ] );
  var got = _.unrollNormalize( _.unrollFrom( src ) );
  test.identical( got, [ [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );

  test.case = 'dst is unroll from array';
  var src = new F32x( [] );
  var got = _.unrollNormalize( _.unrollFrom( src ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.unrollNormalize( _.unrollFrom( src ) );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );

  test.case = 'dst is complex unroll';
  var got = _.unrollNormalize( _.unrollFrom( [ 1, _.unrollFrom ( [ 2, _.unrollFrom( [ 'str' ] ) ] ) ] ) );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );

  test.case = 'mixed types';
  var a = _.unrollMake( [ 'a', 'b' ] );
  var b = _.unrollFrom( [ 1, 2 ] );
  var got = _.unrollNormalize( [ 0, null, a, b, undefined ] );
  test.identical( got, [ 0, null, 'a', 'b', 1, 2, undefined ] );
  test.is( _.arrayIs( got ) );

  var a = _.unrollMake( [ 'a', 'b' ] );
  var b = _.unrollFrom( [ 1, 2 ] );
  var got = _.unrollNormalize( [ 0, [ null, a ], _.unrollFrom( [ b, undefined ] ) ] );
  test.identical( got, [ 0, [ null, 'a', 'b' ], 1, 2, undefined ] );
  test.is( _.arrayIs( got ) );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'dst is empty';
  test.shouldThrowErrorSync( function()
  {
    _.unrollNormalize();
  });

  test.case = 'two arguments';
  test.shouldThrowErrorSync( function()
  {
    _.unrollNormalize( [], [] );
  });

  test.case = 'dst is not array';
  test.shouldThrowErrorSync( function()
  {
    _.unrollNormalize( null );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollNormalize( 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollNormalize( 'str' );
  });
}

//

function unrollSelect( test )
{
  /* constructors */

  let array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => _.argumentsArrayMake( src );
  function bufferTyped( buf )
  {
    let name = buf.name;
    return ({ [ name ] : function( src ){ return new buf( src ) } })[ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    run( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function run( make )
  {
    test.case = 'without arguments';
    var got = _.unrollSelect();
    var expected = _.unrollMake( [] );
    test.identical( got, expected );

    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst );
    var expected = _.unrollMake( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ 0, dst.length + 2 ] );
    var expected = _.unrollMake( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ 0, dst.length + 2 ], 0 );
    var expected = _.unrollMake( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = _.unrollMake( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ 0, 3 ] );
    var expected = _.unrollMake( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ 0, 3 ], 0 );
    var expected = _.unrollMake( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.unrollSelect( dst, [ -1, 3 ] );
    expected = _.unrollMake( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ 0, -1 ] );
    var expected = _.unrollMake( [] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.unrollSelect( dst, [ -1, 3 ], 0 );
    var expected = _.unrollMake( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( _.unrollIs( got ) );
    test.is( got !== dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.unrollSelect( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.unrollSelect( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.unrollSelect( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.unrollSelect( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.unrollSelect( [ 1 ], 'str' ) );
}

//

/* aaa
unrollAppend, unrollPrepend should have test groups :
- dst is null / unroll / array
- one argument / two arguments / three arguments
- first argument have array / unroll / complex unroll( unroll in unroll in unroll )
- non-first argument have array / unroll / complex unroll( unroll in unroll in unroll / F32x / ArgumentsArray

Dmytro: all tests is added
aaa: In unrollPrepend and unrollAppend test cases groups by number of arguments and it includes other test cases - array, unroll, complex unroll.
In previus routines improve unrollMake and unrollFrom tests.
Notice that unrollIs, unrollIsPopulated have not asserts.
*/

//

function unrollPrepend( test )
{
  test.open( 'one argument' );

  test.case = 'dst is null';
  var got = _.unrollPrepend( null );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is unroll';
  var got = _.unrollPrepend( _.unrollMake( [ 1, 2, 'str' ] ) );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is array';
  var got = _.unrollPrepend( [ 1, 2, 'str' ] );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.close( 'one argument' );

  /* - */

  test.open( 'two arguments' );

  test.case = 'dst is null, second arg is null';
  var got = _.unrollPrepend( null, null );
  test.identical( got, [ null ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is unroll';
  var got = _.unrollPrepend( null, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( null, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is complex unroll';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollPrepend( null, _.unrollFrom( [ 1, 2, a1, a2, 10 ] ) );
  var expected = [ 1, 2, 3, 4, 5, 6, [ 7, 8, 9 ], 10 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is array';
  var got = _.unrollPrepend( null, [ 1, 2, 'str' ] );
  test.identical( got, [ [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollPrepend( null, src );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollPrepend( null, src );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );
  test.isNot( _.unrollIs( got ) );

  //

  test.case = 'dst is array, second arg is null';
  var got = _.unrollPrepend( [ 1 ], null );
  test.identical( got, [ null, 1 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is unroll';
  var got = _.unrollPrepend( [ 1 ], _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str', 1 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( [ 'str', 3 ], src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 'str', 3 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is array';
  var got = _.unrollPrepend( [ 'str', 2 ], [ 1, 2, 'str' ] );
  test.identical( got, [ [ 1, 2, 'str' ], 'str', 2 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollPrepend( [ 'str', 0 ], src );
  test.identical( got, [ 1, 2, 3, 'str', 0 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollPrepend( [ 'str', 0 ], src );
  test.identical( got, [ 1, 2, 'str', 'str', 0 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  //

  test.case = 'dst is unroll, second arg is null';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollPrepend( dst, null );
  test.identical( got, [ null, 1 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is unroll';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollPrepend( dst, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str', 1 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is complex unroll';
  var dst = _.unrollMake( [ 1 ] );
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is array';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollPrepend( dst, [ 1, 2, 'str' ] );
  test.identical( got, [ [ 1, 2, 'str' ], 1 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var dst = _.unrollMake( [ 'str', 0 ] );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 3, 'str', 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var dst = _.unrollMake( [ 'str', 0 ] );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 'str', 'str', 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  //

  test.case = 'dst is complex unroll, second arg is null';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( dst, null );
  test.identical( got, [ null, 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is unroll';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( dst, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str', 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is complex unroll';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is array';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollPrepend( dst, [ 1, 2, 'str' ] );
  test.identical( got, [ [ 1, 2, 'str' ], 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg makes from F32x';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 3, 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg makes from argumentsArray';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollPrepend( dst, src );
  test.identical( got, [ 1, 2, 'str', 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.close( 'two arguments' );

  /* - */

  test.open( 'three arguments or more' );

  test.case = 'dst is null, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollPrepend( null, [ 1, 2, a1 ], [ a2, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, manually unrolled src';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollPrepend( null, 1, 2, a1, a2, 10  );
  var expected = [ 1, 2, 3, 4, 5, 6, [ 7, 8, 9 ], 10 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollPrepend( null, [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollPrepend( null, [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is unroll, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollPrepend( _.unrollFrom( [] ), [ 1, 2 ], a1, [ a2, 10 ] );
  var expected = [ [ 1, 2 ], 3, 4, 5, 6, [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollPrepend( _.unrollMake( [ 0 ] ), [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ], 0 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollPrepend( _.unrollMake( [ 0 ] ), [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ], 0 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is array, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollPrepend( [], [ 1, 2 ], a1, [ a2, 10 ] );
  var expected = [ [ 1, 2 ], 3, 4, 5, 6, [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollPrepend( [ 0 ], [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ], 0 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollPrepend( [ 0 ], [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ], 0 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.close( 'three arguments or more' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.unrollPrepend();
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.unrollPrepend( 1, 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollPrepend( 'str', 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollPrepend( undefined, 1 );
  });
}

//

function unrollAppend( test )
{
  test.open( 'one argument' );

  test.case = 'dst is null';
  var got = _.unrollAppend( null );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is unroll';
  var got = _.unrollAppend( _.unrollMake( [ 1, 2, 'str' ] ) );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is array';
  var got = _.unrollAppend( [ 1, 2, 'str' ] );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.close( 'one argument' );

  /* - */

  test.open( 'two arguments' );

  test.case = 'dst is null, second arg is null';
  var got = _.unrollAppend( null, null );
  test.identical( got, [ null ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is unroll';
  var got = _.unrollAppend( null, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( null, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is complex unroll';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollAppend( null, _.unrollFrom( [ 1, 2, a1, a2, 10 ] ) );
  var expected = [ 1, 2, 3, 4, 5, 6, [ 7, 8, 9 ], 10 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg is array';
  var got = _.unrollAppend( null, [ 1, 2, 'str' ] );
  test.identical( got, [ [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollAppend( null, src );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'dst is null, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollAppend( null, src );
  test.identical( got, [ 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );
  test.is( src !== got );

  //

  test.case = 'dst is array, second arg is null';
  var got = _.unrollAppend( [ 1 ], null );
  test.identical( got, [ 1, null ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is unroll';
  var got = _.unrollAppend( [ 1 ], _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 1, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is complex unroll';
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( [ 'str', 3 ], src );
  test.identical( got, [ 'str', 3, 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg is array';
  var got = _.unrollAppend( [ 'str', 2 ], [ 1, 2, 'str' ] );
  test.identical( got, [ 'str', 2, [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollAppend( [ 'str', 0 ], src );
  test.identical( got, [ 'str', 0, 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollAppend( [ 'str', 0 ], src );
  test.identical( got, [ 'str', 0, 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  //

  test.case = 'dst is unroll, second arg is null';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollAppend( dst, null );
  test.identical( got, [ 1, null ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is unroll';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollAppend( dst, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 1, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is complex unroll';
  var dst = _.unrollMake( [ 1 ] );
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 1, 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg is array';
  var dst = _.unrollMake( [ 1 ] );
  var got = _.unrollAppend( dst, [ 1, 2, 'str' ] );
  test.identical( got, [ 1, [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg makes from F32x';
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var dst = _.unrollMake( [ 'str', 0 ] );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 'str', 0, 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, second arg makes from argumentsArray';
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var dst = _.unrollMake( [ 'str', 0 ] );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 'str', 0, 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  //

  test.case = 'dst is complex unroll, second arg is null';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( dst, null );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', null ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is unroll';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( dst, _.unrollMake( [ 1, 'str' ] ) );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is complex unroll';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1, 2, 1, [], 'str', 'str2' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg is array';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var got = _.unrollAppend( dst, [ 1, 2, 'str' ] );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', [ 1, 2, 'str' ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg makes from F32x';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollMake( new F32x( [ 1, 2, 3 ] ) );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1, 2, 3 ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is complex unroll, second arg makes from argumentsArray';
  var dst = _.unrollFrom( [ 1, 2, _.unrollMake( [ 1, [] ] ), _.unrollFrom( [ 'str', _.unrollMake( [ 'str2' ] ) ] ) ] );
  var src = _.unrollMake( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var got = _.unrollAppend( dst, src );
  test.identical( got, [ 1, 2, 1, [], 'str', 'str2', 1, 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.close( 'two arguments' );

  /* - */

  test.open( 'three arguments or more' );

  test.case = 'dst is null, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollAppend( null, [ 1, 2, a1 ], [ a2, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, manually unrolled src';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollAppend( null, 1, 2, a1, a2, 10  );
  var expected = [ 1, 2, 3, 4, 5, 6, [ 7, 8, 9 ], 10 ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollAppend( null, [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is null, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollAppend( null, [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is unroll, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollAppend( _.unrollFrom( [] ), [ 1, 2 ], a1, [ a2, 10 ] );
  var expected = [ [ 1, 2 ], 3, 4, 5, 6, [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollAppend( _.unrollMake( [ 0 ] ), [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ 0, [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is unroll, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollAppend( _.unrollMake( [ 0 ] ), [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ 0, [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst is array, complex unrolls';
  var a1 = _.unrollFrom( [ 3, 4, _.unrollFrom( [ 5, 6 ] ) ] );
  var a2 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var got = _.unrollAppend( [], [ 1, 2 ], a1, [ a2, 10 ] );
  var expected = [ [ 1, 2 ], 3, 4, 5, 6, [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, next args have unroll from argumentsArray';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( _.argumentsArrayMake( [ 3, 4, _.unrollMake( [ 5, 6 ] ) ] ) );
  var got = _.unrollAppend( [ 0 ], [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ 0, [ 1, 2, 3, 4, 5, 6 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is array, next args have unroll from F32x';
  var a1 = [ 7, _.unrollFrom( [ 8, 9 ] ) ];
  var a2 = _.unrollFrom( new F32x( [ 3, 4 ] ) );
  var got = _.unrollAppend( [ 0 ], [ 1, 2, a2 ], [ a1, 10 ] );
  var expected = [ 0, [ 1, 2, 3, 4 ], [ [ 7, 8, 9 ], 10 ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );

  test.close( 'three arguments or more' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.unrollAppend();
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.unrollAppend( 1, 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollAppend( 'str', 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.unrollAppend( undefined, 1 );
  });
}

//

function unrollRemove( test )
{
  test.case = 'dst is null'
  var got = _.unrollRemove( null, 0 );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( null, 'str' );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( null, null );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( null, [ 1, 2, 'str' ] );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( null, _.unrollMake( [ 1 ] ) );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'dst is unroll from null'
  var got = _.unrollRemove( _.unrollMake( null ), 'str' );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var got = _.unrollRemove( _.unrollMake( null ), _.unrollMake( [ 1 ] ) );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var got = _.unrollRemove( _.unrollMake( null ), _.unrollMake( null ) );
  test.equivalent( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  /* - */

  test.open( 'dstArray is array' );

  test.case = 'array remove element';
  var got = _.unrollRemove( [ 1, 1, 2, 'str' ], 1 );
  test.equivalent( got, [ 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str' ], 'str' );
  test.equivalent( got, [ 1, 1, 2 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str', {} ], 0 );
  test.equivalent( got, [ 1, 1, 2, 'str', {} ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'array remove array or object';
  var got = _.unrollRemove( [ 1, 1, 2, 'str', [ 0 ] ], [ 0 ] );
  test.equivalent( got, [ 1, 1, 2, 'str', [ 0 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str', { a : 1, b : 'str' } ], { a : 1, b : 'str' } );
  test.equivalent( got, [ 1, 1, 2, 'str', { a : 1, b : 'str' } ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'array remove elements';
  var got = _.unrollRemove( [ 1, 1, 2, 'str', [ 1 ] ], 1, [ 1 ] );
  test.equivalent( got, [ 2, 'str', [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str', { a : 2 }, 'str' ], 0, { a : 2 }, 4, 'str' );
  test.equivalent( got, [ 1, 1, 2, { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str', { a : 2 } ], null, undefined, 4, [] );
  test.equivalent( got, [ 1, 1, 2, 'str', { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'array remove elements included array or object';
  var got = _.unrollRemove( [ 1, 1, 2, 'str', [ 0 ] ], 1, [ 0 ] );
  test.equivalent( got, [ 2, 'str', [ 0 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 1, 2, 'str', { a : 1, b : 'str' } ], 2, 'str', { a : 1, b : 'str' } );
  test.equivalent( got, [ 1, 1, { a : 1, b : 'str' } ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'array remove unroll';
  var got = _.unrollRemove( [ 1, 1, 2, 3, 'str', 3 ], _.unrollFrom( [ 1, 3 ] ) );
  test.equivalent( got, [ 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 2, 1, 3, 'str', [ 1 ] ], _.unrollFrom( [ 1, 3, 'str', [ 1 ] ] ) );
  test.equivalent( got, [ 2, [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.unrollRemove( [ 1, 2, 3, 'str', [ 1 ] ], _.unrollFrom( [ 0, 'a', [ 2 ] ] ) );
  test.equivalent( got, [ 1, 2, 3, 'str', [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var ins =  _.unrollFrom( [ 1, _.unrollMake( [ 2, 3, _.unrollMake( [ 'str', [ 1 ] ] ) ] ) ] );
  var got = _.unrollRemove( [ 1, 2, 3, 'str', [ 1 ] ], ins );
  test.equivalent( got, [ [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.close( 'dstArray is array' );

  /* - */

  test.open( 'dstArray is unroll' );

  test.case = 'unroll remove element';
  var dst = _.unrollMake( [ 1, 1, 2, 'str', [ 1 ] ] );
  var got = _.unrollRemove( dst, 1);
  test.equivalent( got, [ 2, 'str', [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 1, 2, 'str', { a : 2 }, 'str' ] );
  var got = _.unrollRemove( dst, 'str' );
  test.equivalent( got, [ 1, 1, 2, { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 1, 2, 'str', { a : 2 } ] );
  var got = _.unrollRemove( dst, 4 );
  test.equivalent( got, [ 1, 1, 2, 'str', { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'unroll remove elements';
  var dst = _.unrollMake( [ 1, 1, 2, 'str', [ 1 ] ] );
  var got = _.unrollRemove( dst, 1, [ 1 ] );
  test.equivalent( got, [ 2, 'str', [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 1, 2, 'str', { a : 2 }, 'str' ] );
  var got = _.unrollRemove( dst, 0, { a : 2 }, 4, 'str' );
  test.equivalent( got, [ 1, 1, 2, { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 1, 2, 'str', { a : 2 } ] );
  var got = _.unrollRemove( dst, null, undefined, 4, [] );
  test.equivalent( got, [ 1, 1, 2, 'str', { a : 2 } ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.case = 'unroll remove unroll';
  var dst = _.unrollMake( [ 1, 1, 2, 3, 'str', 3 ] );
  var got = _.unrollRemove( dst, _.unrollFrom( [ 1, 3 ] ) );
  test.equivalent( got, [ 2, 'str' ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 2, 1, 3, 'str', [ 1 ] ] );
  var got = _.unrollRemove( dst, _.unrollFrom( [ 1, 3, 'str', [ 1 ] ] ) );
  test.equivalent( got, [ 2, [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var dst = _.unrollMake( [ 1, 2, 3, 'str', [ 1 ] ] );
  var got = _.unrollRemove( dst, _.unrollFrom( [ 0, 'a', [ 2 ] ] ) );
  test.equivalent( got, [ 1, 2, 3, 'str', [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  var ins =  _.unrollFrom( [ 1, _.unrollMake( [ 2, 3, _.unrollMake( [ 'str', [ 1 ] ] ) ] ) ] );
  var got = _.unrollRemove( _.unrollFrom( [ 1, 2, 3, 'str', [ 1 ] ] ), ins );
  test.equivalent( got, [ [ 1 ] ] );
  test.is( _.arrayIs( got ) );
  test.is( _.unrollIs( got ) );

  test.close( 'dstArray is unroll' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.unrollRemove() );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.unrollRemove( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.unrollRemove( 'wrong', 1 ) );
  test.shouldThrowErrorSync( () => _.unrollRemove( undefined, 1 ) );
}

// --
//
// --

var Self =
{

  name : 'Tools.base.Unroll',
  silencing : 1,
  enabled : 1,

  tests :
  {

    unrollIs,
    unrollIsPopulated,

    unrollMake,
    unrollMakeLongDescriptor,
    unrollMakeUndefined,
    unrollMakeUndefinedLongDescriptor,
    unrollFrom,
    unrollFromLongDescriptor,
    unrollsFrom,
    unrollsFromLongDescriptor,
    unrollFromMaybe,
    unrollFromMaybeLongDescriptor,
    unrollNormalize,

    unrollSelect,

    unrollPrepend,
    unrollAppend,
    unrollRemove,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
