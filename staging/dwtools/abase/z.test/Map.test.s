( function _Map_test_s( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

}

var _ = _global_.wTools;

//

function mapIs( test )
{

  test.description = 'an empty object';
  var got = _.mapIs( {} );
  var expected = true;
  test.identical( got, expected );

  test.description = 'an object';
  var got = _.mapIs( { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.description = 'no argument';
  var got = _.mapIs();
  var expected = false;
  test.identical( got, expected );

  test.description = 'an array';
  var got = _.mapIs( [  ] );
  var expected = false;
  test.identical( got, expected );

  test.description = 'a string';
  var got = _.mapIs( 'str' );
  var expected = false;
  test.identical( got, expected );

  test.description = 'a number';
  var got = _.mapIs( 13 );
  var expected = false;
  test.identical( got, expected );

  test.description = 'a boolean';
  var got = _.mapIs( true );
  var expected = false;
  test.identical( got, expected );

  test.description = 'a function';
  var got = _.mapIs( function() {  } );
  var expected = false;
  test.identical( got, expected );

  test.description = 'a string';
  var got = _.mapIs( Object.create( { a : 7 } ) );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    /*test.description = 'inherits through the prototype chain';
    test.shouldThrowError( function()
    {
      _.mapIs( Object.create( { a : 7 } ) );
    });*/

  }

};

//

function mapClone( test )
{

  test.description = 'an Example';
  function Example() {
    this.name = 'Peter';
    this.age = 27;
  };
  var got = _.mapClone( new Example(), { dst : { sex : 'Male' } } );
  var expected = { sex : 'Male', name : 'Peter', age : 27 };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.mapClone();
    });

    test.description = 'redundant argument';
    test.shouldThrowError( function()
    {
      _.mapClone( {}, {}, 'wrong arguments' );
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapClone( [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapClone( 'wrong arguments' );
    });

  }

};

//

function mapExtendConditional( test )
{

  test.description = 'an unique object';
  debugger;
  var got = _.mapExtendConditional( _.field.mapper.dstNotHas, { a : 1, b : 2 }, { a : 1 , c : 3 } );
  var expected = { a : 1, b : 2, c : 3 };
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional();
  });

  test.description = 'few argument';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional( _.field.mapper.dstNotHas );
  });

  test.description = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional( [] );
  });

  test.description = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional( 'wrong arguments' );
  });

}

//

function mapExtend( test )
{

  test.description = 'first argument is null';
  var got = _.mapExtend( null, { a : 7, b : 13 }, { c : 3, d : 33 } );
  var expected = { a : 7, b : 13, c : 3, d : 33 };
  test.identical( got, expected );

  test.description = 'multiple object properties';
  var got = _.mapExtend( { a : 7, b : 13 }, { c : 3, d : 33 }, { e : 77 } );
  var expected = { a : 7, b : 13, c : 3, d : 33, e : 77 };
  test.identical( got, expected );

  test.description = 'object like array';
  var got = _.mapExtend( null, [ 3, 7, 13, 73 ] );
  var expected = { 0 : 3, 1 : 7, 2 : 13, 3 : 73 };
  test.identical( got, expected );

  test.description = 'object like array2';
  var got = _.mapExtend( { a : 7, b : 13 }, [ 33, 3, 7, 13 ] );
  var expected = { 0 : 33, 1 : 3, 2 : 7, 3 : 13, a : 7, b : 13 };
  test.identical(got, expected);

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapExtend();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapExtend( {} );
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapExtend( [] );
    });

    test.description = 'wrong type of number';
    test.shouldThrowError( function()
    {
      _.mapExtend( 13 );
    });

    test.description = 'wrong type of boolean';
    test.shouldThrowError( function()
    {
      _.mapExtend( true );
    });

    test.description = 'first argument is wrong';
    test.shouldThrowError( function()
    {
      _.mapExtend( 'wrong argument' );
    });

  }

};

//

function mapSupplement( test )
{

  test.description = 'an object';
  var got = _.mapSupplement( { a : 1, b : 2 }, { a : 1, c : 3 } );
  var expected = { a : 1, b : 2, c : 3 };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapSupplement();
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapSupplement( [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapSupplement( 'wrong arguments' );
    });

  }

};

//

function mapComplement( test )
{

  test.description = 'an object';
  var got = _.mapComplement( { a : 1, b : 'yyy' }, { a : 12 , c : 3 } );
  var expected = { a : 1, b : 'yyy', c : 3 };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapComplement();
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapComplement( [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapComplement( 'wrong arguments' );
    });

  }

};

//

function mapCopy( test )
{

  test.description = 'an object';
  var got = _.mapCopy( { a : 7, b : 13 }, { c : 3, d : 33 }, { e : 77 } );
  var expected = { a : 7, b : 13, c : 3, d : 33, e : 77 };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapCopy();
    });

  }

};

//

function mapFirstPair( test )
{

  test.description = 'first pair [ key, value ]';
  var got = _.mapFirstPair( { a : 3, b : 13 } );
  var expected = [ 'a', 3 ];
  test.identical( got, expected );

  test.description = 'undefined';
  var got = _.mapFirstPair( {} );
  var expected = [];
  test.identical( got, expected );

  test.description = 'pure map';
  var obj = Object.create( null );
  obj.a = 7;
  var got = _.mapFirstPair( obj );
  var expected = [ 'a', 7 ];
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapFirstPair();
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapFirstPair( 'wrong argument' );
    });

  }

};

//

function mapToArray( test )
{

  test.description = 'a list of [ key, value ] pairs'
  var got = _.mapToArray( { a : 3, b : 13, c : 7 } );
  var expected = [ [ 'a', 3 ], [ 'b', 13 ], [ 'c', 7 ] ];
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapToArray();
    });

    test.description = 'redundant argument';
    test.shouldThrowError( function()
    {
      _.mapToArray( {}, 'wrong arguments' );
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapToArray( [] );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapToArray( 'wrong argumetns' );
    });

  }

};

//

function mapValWithIndex( test )
{

  test.description = 'second index';
  var got = _.mapValWithIndex( { 0 : 3, 1 : 13, 2 : 'c', 3 : 7 }, 2 );
  var expected = 'c';
  test.identical( got, expected );

  test.description = 'an element';
  var got = _.mapValWithIndex( { 0 : [ 'a', 3 ] }, 0 );
  var expected = [ 'a', 3 ];
  test.identical( got, expected );

  test.description = 'a list of arrays';
  var got = _.mapValWithIndex( { 0 : [ 'a', 3 ], 1 : [ 'b', 13 ], 2 : [ 'c', 7 ] }, 2 );
  var expected = ["c", 7];
  test.identical( got, expected );

  test.description = 'a list of objects';
  var got = _.mapValWithIndex( { 0 : { a : 3 }, 1 : { b : 13 }, 2 : { c : 7 } }, 2 );
  var expected = {c: 7};
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function() {
      _.mapValWithIndex();
    });

    test.description = 'few argument';
    test.shouldThrowError( function()
    {
      _.mapValWithIndex( [ [] ] );
    });

    test.description = 'first the four argument not wrapped into array';
    test.shouldThrowError( function()
    {
      _.mapValWithIndex( 3, 13, 'c', 7 , 2 );
    });

    test.description = 'redundant argument';
    test.shouldThrowError( function()
    {
      _.mapValWithIndex( [ [] ], 2, 'wrong arguments' );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapValWithIndex( 'wrong argumetns' );
    });

  }

}

//

function mapKeyWithIndex( test )
{

  test.description = 'last key';
  var got = _.mapKeyWithIndex( { 'a': 3, 'b': 13, 'c': 7 }, 2 );
  var expected = 'c';
  test.identical( got, expected );

  test.description = 'first key';
  var got = _.mapKeyWithIndex( { 0 : { a : 3 },  1 : 13, 2 : 'c', 3 : 7 }, 3 );
  var expected = '3';
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapKeyWithIndex();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapKeyWithIndex( [] );
    });

    test.description = 'redundant argument';
    test.shouldThrowError( function()
    {
      _.mapKeyWithIndex( [  ], 2, 'wrong arguments' );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapKeyWithIndex( 'wrong argumetns' );
    });

  }

};

//

function mapToStr( test )
{

  test.description = 'returns an empty string';
  var got = _.mapToStr({ src : [  ], valKeyDelimeter : ' : ',  entryDelimeter : '; '});
  var expected = '';
  test.identical( got, expected );

  test.description = 'returns a string representing an object';
  var got = _.mapToStr({ src : { a : 1, b : 2, c : 3, d : 4 }, valKeyDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = 'a : 1; b : 2; c : 3; d : 4';
  test.identical( got, expected );

  test.description = 'returns a string representing an array';
  var got = _.mapToStr({ src : [ 1, 2, 3 ], valKeyDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : 1; 1 : 2; 2 : 3';
  test.identical( got, expected );

  test.description = 'returns a string representing an array-like object';
  function args() { return arguments };
  var got = _.mapToStr({ src : args(  1, 2, 3, 4, 5 ), valKeyDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : 1; 1 : 2; 2 : 3; 3 : 4; 4 : 5';
  test.identical( got, expected );

  test.description = 'returns a string representing a string';
  var got = _.mapToStr({ src : 'abc', valKeyDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : a; 1 : b; 2 : c';
  test.identical( got, expected );


  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapToStr();
    });

    test.description = 'wrong type of number';
    test.shouldThrowError( function()
    {
      _.mapToStr( 13 );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapToStr( true );
    });

  }

};

//

function mapKeys( test )
{
  test.description = 'trivial';

  // var got = _.mapKeys( {} );
  // var expected = [];
  //
  // var got = _.mapKeys( { a : 7, b : 13 } );
  // var expected = [ 'a', 'b' ];
  // test.identical( got, expected );
  //
  // var got = _.mapKeys( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  // var expected = [ '3', '7', '13' ];
  // test.identical( got, expected );
  //
  // var f = function(){};
  // Object.setPrototypeOf( f, String );
  // f.a = 1;
  // var got = _.mapKeys( f );
  // var expected = [ 'a' ];
  // test.identical( got, expected );
  //
  // var got = _.mapKeys( new Date );
  // var expected = [ ];
  // test.identical( got, expected );
  //
  // //
  //
  // test.description = 'options';
  // var a = { a : 1 }
  // var b = { b : 2 }
  // Object.setPrototypeOf( a, b );
  //
  // /* own off */
  //
  // var got = _.mapKeys( a );
  // var expected = [ 'a', 'b' ];
  // test.identical( got, expected );
  //
  // /* own on */
  //
  // var o = { own : 1 };
  // var got = _.mapKeys.call( o, a );
  // var expected = [ 'a' ];
  // test.identical( got, expected );
  //
  // /* enumerable/own off */
  //
  // var o = { enumerable : 0, own : 0 };
  // Object.defineProperty( b, 'k', { enumerable : 0 } );
  // var got = _.mapKeys.call( o, a );
  // var expected = _.mapAllKeys( a );
  // test.identical( got, expected );
  //
  // /* enumerable off, own on */
  //
  // var o = { enumerable : 0, own : 1 };
  // Object.defineProperty( a, 'k', { enumerable : 0 } );
  // var got = _.mapKeys.call( o, a );
  // var expected = [ 'a', 'k' ]
  // test.identical( got, expected );

  //

  if( Config.debug )
  {

    // test.description = 'no argument';
    // test.shouldThrowError( function()
    // {
    //   _.mapKeys();
    // });
    //
    // test.description = 'wrong type of argument';
    // test.shouldThrowError( function()
    // {
    //   _.mapKeys( 'wrong arguments' );
    // });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      debugger;
      _.mapKeys.call( { x : 1 }, {} );
      debugger;
    });

  }

};

//

function mapOwnKeys( test )
{
  test.description = 'empty'
  var got = _.mapOwnKeys( {} );
  var expected = [];
  test.identical( got, expected )

  //

  test.description = 'simplest'

  var got = _.mapOwnKeys( { a : '1', b : '2' } );
  var expected = [ 'a', 'b' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( new Date );
  var expected = [ ];
  test.identical( got, expected )

  //

  test.description = ''

  var a = { a : 1 };
  var b = { b : 2 };
  var c = { c : 3 };
  Object.setPrototypeOf( a, b );
  Object.setPrototypeOf( b, c );

  var got = _.mapOwnKeys( a );
  var expected = [ 'a' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( b );
  var expected = [ 'b' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( c );
  var expected = [ 'c' ];
  test.identical( got, expected );

  //

  test.description = 'enumerable on/off';
  var a = { a : '1' };

  var got = _.mapOwnKeys( a );
  var expected = [ 'a' ]
  test.identical( got, expected );

  Object.defineProperty( a, 'k', { enumerable : false } );
  var o = { enumerable : 0 };
  var got = _.mapOwnKeys.call( o, a );
  var expected = [ 'a', 'k' ]
  test.identical( got, expected );

  //

  if( Config.debug )
  {
    test.description = 'no args';
    test.shouldThrowError( function()
    {
      _.mapOwnKeys();
    })

    test.description = 'invalid type';
    test.shouldThrowError( function()
    {
      _.mapOwnKeys( 1 );
    })

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapOwnKeys.call( { own : 0 }, {} );
    })
  }

}

//

function mapAllKeys( test )
{
  var _expected =
  [
    "__defineGetter__",
    "__defineSetter__",
    "hasOwnProperty",
    "__lookupGetter__",
    "__lookupSetter__",
    "propertyIsEnumerable",
    "__proto__",
    "constructor",
    "toString",
    "toLocaleString",
    "valueOf",
    "isPrototypeOf"
  ]

  //

  test.description = 'empty'
  var got = _.mapAllKeys( {} );
  test.identical( got.sort(), _expected.sort() )

  //

  test.description = 'one own property'
  var got = _.mapAllKeys( { a : 1 } );
  var expected = _expected.slice();
  expected.push( 'a' );
  test.identical( got.sort(), expected.sort() )

  //

  test.description = 'date'
  var got = _.mapAllKeys( new Date );
  test.identical( got.length, 55 );

  //

  test.description = 'not enumerable'
  var a = { };
  Object.defineProperty( a, 'k', { enumerable : 0 })
  var got = _.mapAllKeys( a );
  var expected = _expected.slice();
  expected.push( 'k' );
  test.identical( got.sort(), expected.sort() );

  //

  test.description = 'from prototype'
  var a = { a : 1 };
  var b = { b : 1 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( a, 'k', { enumerable : 0 } );
  Object.defineProperty( b, 'y', { enumerable : 0 } );
  var got = _.mapAllKeys( a );
  var expected = _expected.slice();
  expected = expected.concat( [ 'a','b','k','y' ] );
  test.identical( got.sort(), expected.sort() );

  //

  if( Config.debug )
  {
    test.description = 'no args';
    test.shouldThrowError( function()
    {
      _.mapAllKeys();
    })

    test.description = 'invalid argument';
    test.shouldThrowError( function()
    {
      _.mapAllKeys();
    })

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapAllKeys.call( { own : 0 }, {} );
    })
  }

}

//

function mapVals( test )
{

  test.description = 'trivial';

  var got = _.mapVals( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapVals( { a : 7, b : 13 } );
  var expected = [ 7, 13 ];
  test.identical( got, expected );

  var got = _.mapVals( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  var expected = [ 'b', 'a', 'c' ];
  test.identical( got, expected );

  var got = _.mapVals( new Date );
  var expected = [ ];
  test.identical( got, expected );

  //

  test.description = 'own'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapVals.call( { own : 0, enumerable : 1 }, a );
  var expected = [ 1, 2 ]
  test.identical( got, expected );

  /**/

  var got = _.mapVals.call( { own : 1, enumerable : 1 }, a );
  var expected = [ 1 ];
  test.identical( got, expected );

  //

  test.description = 'enumerable'
  var a = { a : 1 };
  Object.defineProperty( a, 'k', { enumerable : 0, value : 2 } );

  /**/

  var got = _.mapVals.call( { enumerable : 1, own : 0 }, a );
  var expected = [ 1 ];
  test.identical( got, expected );

  /**/

  var got = _.mapVals.call( { enumerable : 0, own : 0 }, a );
  var contains = false;
  for( var i = 0; i < got.length; i++ )
  {
    contains = _.mapContain( a, got[ i ] )
    if( !contains )
    break;
  }
  test.shouldBe( contains );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapVals();
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapVals( 'wrong argument' );
    });

    test.description = 'wrong option';
    test.shouldThrowError( function()
    {
      _.mapVals.call( { a : 1 }, {} );
    });
  }
};

//

function mapOwnVals( test )
{

  test.description = 'trivial';

  var got = _.mapOwnVals( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapOwnVals( { a : 7, b : 13 } );
  var expected = [ 7, 13 ];
  test.identical( got, expected );

  var got = _.mapOwnVals( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  var expected = [ 'b', 'a', 'c' ];
  test.identical( got, expected );

  var got = _.mapOwnVals( new Date );
  var expected = [ ];
  test.identical( got, expected );

  //

  test.description = ' only own values'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnVals( a );
  var expected = [ 1 ];
  test.identical( got, expected );

  /* enumerable off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  Object.defineProperty( b, 'y', { enumerable : 0, value : 4 } );
  var got = _.mapOwnVals.call({ enumerable : 0 }, a );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnVals();
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnVals( 'wrong argument' );
    });

    test.description = 'wrong option';
    test.shouldThrowError( function()
    {
      _.mapOwnVals.call( { a : 1 }, {} );
    });

  }

};

//

function mapAllVals( test )
{
  test.description = 'trivial';

  var got = _.mapAllVals( {} );
  test.shouldBe( got.length );

  /**/

  var got = _.mapAllVals( { a : 7, b : 13 } );
  test.shouldBe( got.length );
  test.shouldBe( got.indexOf( 7 ) !== -1 );
  test.shouldBe( got.indexOf( 13 ) !== -1 );

  /**/

  var got = _.mapAllVals( new Date );
  test.shouldBe( got.length > _.mapAllVals( {} ).length );

  //

  test.description = 'from prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllVals( a );
  var expected = [ 1 ];
  test.shouldBe( got.length > _.mapAllVals( {} ).length );
  test.shouldBe( got.indexOf( 1 ) !== -1 );
  test.shouldBe( got.indexOf( 2 ) !== -1 );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapAllVals();
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapAllVals( 'wrong argument' );
    });

    test.description = 'wrong option';
    test.shouldThrowError( function()
    {
      _.mapAllVals.call( { a : 1 }, {} );
    });

  }

};

//

function mapPairs( test )
{
  test.description = 'empty';
  var got = _.mapPairs( {} );
  var expected = [];
  test.identical( got, expected );

  //

  test.description = 'a list of [ key, value ] pairs';

  var got = _.mapPairs( { a : 7, b : 13 } );
  var expected = [ [ "a", 7 ], [ "b", 13 ] ];
  test.identical( got, expected );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapPairs( arrObj );
  var expected = [ [ 'k', 1 ] ];
  test.identical( got, expected );

  /**/

  var got = _.mapPairs( new Date );
  var expected = [];
  test.identical( got, expected );

  //

  test.description = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapPairs( a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  /* using own */

  var got = _.mapPairs.call( { own : 1 }, a );
  var expected = [ [ 'a', 1 ] ];
  test.identical( got, expected );

  /* using enumerable off, own on */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapPairs.call( { enumerable : 0, own : 1 }, a );
  var expected = [ [ 'a', 1 ], [ 'k', 3 ] ];
  test.identical( got, expected );

  /* using enumerable off, own off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapPairs.call( { enumerable : 0, own : 0 }, a );
  test.shouldBe( got.length > 2 );
  test.identical( got[ 0 ], [ 'a', 1 ] );
  test.identical( got[ 1 ], [ 'k', 3 ] );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapPairs();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapPairs( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapPairs( 'wrong argument' );
    });

  }

};

//

function mapOwnPairs( test )
{
  test.description = 'empty';
  var got = _.mapOwnPairs( {} );
  var expected = [];
  test.identical( got, expected );

  //

  test.description = 'a list of [ key, value ] pairs';

  var got = _.mapOwnPairs( { a : 7, b : 13 } );
  var expected = [ [ "a", 7 ], [ "b", 13 ] ];
  test.identical( got, expected );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapOwnPairs( arrObj );
  var expected = [ [ 'k', 1 ] ];
  test.identical( got, expected );

  /**/

  var got = _.mapOwnPairs( new Date );
  var expected = [];
  test.identical( got, expected );

  //

  test.description = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapOwnPairs( a );
  var expected = [ [ 'a', 1 ] ];
  test.identical( got, expected );

  /* using enumerable off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnPairs.call( { enumerable : 0 }, a );
  var expected = [ [ 'a', 1 ], [ 'k', 3 ] ];
  test.identical( got, expected );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnPairs();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapOwnPairs( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnPairs( 'wrong argument' );
    });

  }

};

//

function mapAllPairs( test )
{
  test.description = 'empty';
  var got = _.mapAllPairs( {} );
  test.shouldBe( got.length );

  //

  test.description = 'a list of [ key, value ] pairs';

  var got = _.mapAllPairs( { a : 7, b : 13 } );
  test.shouldBe( got.length > 2 );
  test.identical( got[ 0 ], [ "a", 7 ] );
  test.identical( got[ 1 ], [ "b", 13 ] );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapAllPairs( arrObj );
  test.shouldBe( got.length > 1 );
  got = _.arrayFlatten( [], got );
  test.shouldBe( got.indexOf( 'k' ) !== -1 );
  test.identical( got[ got.indexOf( 'k' ) + 1 ], 1 );

  /**/

  var got = _.mapAllPairs( new Date );
  test.shouldBe( got.length > 1 );
  got = _.arrayFlatten( [], got );
  test.shouldBe( got.indexOf( 'constructor' ) !== -1 );
  test.identical( got[ got.indexOf( 'constructor' ) + 1 ].name, 'Date' );

  //

  test.description = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapAllPairs( a );
  test.shouldBe( got.length > 2 );
  test.identical( got[ 0 ], [ "a", 1 ] );
  test.identical( got[ 1 ], [ "b", 2 ] );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapAllPairs();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapAllPairs( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapAllPairs( 'wrong argument' );
    });

  }

};

//

function mapProperties( test )
{
  test.description = 'empty';

  var got = _.mapProperties( {} );
  test.identical( got, {} );

  var got = _.mapProperties( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapProperties( { a : 1 } );
  var expected = { a : 1 };
  test.identical( got, expected );

  var a = [];
  a.a = 1;
  var got = _.mapProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  var got = _.mapProperties( new String );
  var expected = {};
  test.identical( got, expected );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapProperties( a );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );

  /**/

  var got = _.mapProperties.call( { own : 1, enumerable : 1 }, a );
  var expected = { a : 1 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapProperties.call( { enumerable : 0, own : 1 }, a );
  var expected = { a : 1, k : 3 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapProperties.call( { enumerable : 0, own : 0 }, a );
  test.shouldBe( Object.keys( got ).length > 3 );
  test.shouldBe( got.a === 1 );
  test.shouldBe( got.b === 2 );
  test.shouldBe( got.k === 3 );

  /**/

  var got = _.mapProperties.call( { enumerable : 0, own : 0 }, new Number );
  test.shouldBe( Object.keys( got ).length );
  test.shouldBe( got.constructor.name === 'Number' );
  test.shouldBe( _.routineIs( got.toFixed ) );
  test.shouldBe( got.__proto__ );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapProperties();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapProperties( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapProperties( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapProperties.call( { x : 1 }, {} );
    });

  }

};

//

function mapOwnProperties( test )
{
  test.description = 'empty';

  var got = _.mapOwnProperties( {} );
  test.identical( got, {} );

  var got = _.mapOwnProperties( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapOwnProperties( { a : 1 } );
  var expected = { a : 1 };
  test.identical( got, expected );

  var a = [];
  a.a = 1;
  var got = _.mapOwnProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  var got = _.mapOwnProperties( new String );
  var expected = {};
  test.identical( got, expected );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnProperties.call( { enumerable : 0 }, a );
  var expected = { a : 1, k : 3 };
  test.identical( got, expected );

  /**/

  var got = _.mapOwnProperties.call( { enumerable : 0 }, new Number );
  test.identical( got, {} )

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnProperties();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapOwnProperties( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnProperties( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapOwnProperties.call( { x : 1 }, {} );
    });

  }

};

//

function mapAllProperties( test )
{
  test.description = 'empty';

  var got = _.mapAllProperties( {} );
  test.shouldBe( Object.keys( got ).length  )
  test.identical( got.constructor.name, 'Object' );

  var got = _.mapAllProperties( [] );
  test.shouldBe( Object.keys( got ).length  )
  test.identical( got.constructor.name, 'Array' );

  //

  test.description = 'trivial';

  var got = _.mapAllProperties( { a : 1 } );
  test.shouldBe( Object.keys( got ).length > 1 )
  test.identical( got.a, 1 );

  var a = [];
  a.a = 1;
  var got = _.mapAllProperties( a );
  test.shouldBe( Object.keys( got ).length > 1 )
  var expected = { a : 1 };
  test.identical( got.a, 1 );

  var got = _.mapAllProperties( new String );
  test.shouldBe( Object.keys( got ).length )
  test.identical( got.length, 0 );
  test.identical( got.constructor.name, 'String' );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllProperties( a );
  test.shouldBe( Object.keys( got ).length > 2 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllProperties( a );
  test.shouldBe( Object.keys( got ).length > 3 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );

  /**/

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : undefined } );
  var got = _.mapAllProperties( a );
  test.shouldBe( Object.keys( got ).length > 3 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, undefined );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapAllProperties();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapAllProperties( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapAllProperties( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapAllProperties.call( { x : 1 }, {} );
    });

  }

};

//

function mapRoutines( test )
{
  test.description = 'empty';

  var got = _.mapRoutines( {} );
  test.identical( got, {} );

  var got = _.mapRoutines( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapRoutines( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapRoutines( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.a ) );

  var got = _.mapRoutines( new String );
  test.identical( got, {} );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapRoutines( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapRoutines( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.c ) );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapRoutines.call( { enumerable : 0 }, a );
  test.shouldBe( Object.keys( got ).length > 1 )
  test.shouldBe( _.routineIs( got.c ) );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );


  /**/

  a.y = function(){}
  var got = _.mapRoutines.call( { own : 1 }, a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.y ) );

  /* own : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  var got = _.mapRoutines.call( { own : 0 }, a );
  test.shouldBe( Object.keys( got ).length === 2 )
  test.shouldBe( _.routineIs( got.y ) );
  test.shouldBe( _.routineIs( got.c ) );

  /* own : 0, enumerable : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapRoutines.call( { own : 0, enumerable : 0 }, a );
  test.shouldBe( Object.keys( got ).length > 3 )
  test.shouldBe( _.routineIs( got.y ) );
  test.shouldBe( _.routineIs( got.c ) );
  test.shouldBe( _.routineIs( got.k ) );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapRoutines();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapRoutines( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapRoutines( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapRoutines.call( { x : 1 }, {} );
    });

  }

};

//

function mapOwnRoutines( test )
{
  test.description = 'empty';

  var got = _.mapOwnRoutines( {} );
  test.identical( got, {} );

  var got = _.mapOwnRoutines( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapOwnRoutines( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapOwnRoutines( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( _.routineIs( got.a ) );

  var got = _.mapRoutines( new String );
  test.identical( got, {} );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  var a = {};
  var b = {};
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnRoutines.call( { enumerable : 0 }, a );
  test.identical( got, {} );

  /* enumerable : 0 */

  var a = {};
  var b = {};
  Object.defineProperty( a, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapOwnRoutines.call( { enumerable : 0 }, a );
  test.identical( got.k, a.k );
  test.shouldBe( _.routineIs( got.k ) );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnRoutines();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapOwnRoutines( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnRoutines( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapOwnRoutines.call( { x : 1 }, {} );
    });

  }

};

//

function mapAllRoutines( test )
{
  test.description = 'empty';

  var got = _.mapAllRoutines( {} );
  test.shouldBe( Object.keys( got ).length );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );

  var got = _.mapAllRoutines( [] );
  test.shouldBe( Object.keys( got ).length );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );

  //

  test.description = 'trivial';

  var got = _.mapAllRoutines( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );
  test.shouldBe( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapAllRoutines( a );
  test.shouldBe( Object.keys( got ).length );
  test.shouldBe( _.routineIs( got.__defineGetter__ ) );
  test.shouldBe( _.routineIs( got.__defineSetter__ ) );
  test.shouldBe( _.routineIs( got.a ) );

  var got = _.mapAllRoutines( new String );
  test.shouldBe( Object.keys( got ).length );
  test.identical( got.constructor.name, 'String' );
  test.shouldBe( _.routineIs( got.sub ) );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllRoutines( a );
  test.shouldBe( Object.keys( got ).length > 1 );
  test.shouldBe( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllRoutines( a );
  test.shouldBe( Object.keys( got ).length > 1 );
  test.shouldBe( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( a, 'z', { enumerable : 0, value : function(){} } );
  Object.defineProperty( b, 'y', { enumerable : 0, value : function(){} } );
  var got = _.mapAllRoutines( a );
  test.shouldBe( Object.keys( got ).length > 2 );
  test.shouldBe( _.routineIs( got.c ) );
  test.shouldBe( _.routineIs( got.y ) );
  test.shouldBe( _.routineIs( got.z ) );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapAllRoutines();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapAllRoutines( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapAllRoutines( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapAllRoutines.call( { x : 1 }, {} );
    });

  }

};

//

function mapFields( test )
{
  test.description = 'empty';

  var got = _.mapFields( {} );
  test.identical( got, {} );

  var got = _.mapFields( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapFields( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( got.a === 1 );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapFields( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( got.b === 1 );

  var got = _.mapFields( new String );
  test.identical( got, {} );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapFields( a );
  test.shouldBe( Object.keys( got ).length === 2 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapFields( a );
  test.shouldBe( Object.keys( got ).length === 2 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapFields.call( { enumerable : 0 }, a );
  test.shouldBe( Object.keys( got ).length === 4 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );

  /**/

  a.y = function(){}
  var got = _.mapFields.call( { own : 1 }, a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.identical( got.a, 1 );

  /* own : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  var got = _.mapFields.call( { own : 0, enumerable : 1 }, a );
  test.shouldBe( Object.keys( got ).length === 2 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /* enumerable : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  Object.defineProperty( b, 'z', { enumerable : 0, value : 3 } );
  var got = _.mapFields.call( { enumerable : 0 }, a );
  test.identical( Object.keys( got ).length, 4 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.z, 3 );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapFields();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapFields( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapFields( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapFields.call( { x : 1 }, {} );
    });

  }

};

//

function mapOwnFields( test )
{
  test.description = 'empty';

  var got = _.mapOwnFields( {} );
  test.identical( got, {} );

  var got = _.mapOwnFields( [] );
  test.identical( got, {} );

  //

  test.description = 'trivial';

  var got = _.mapOwnFields( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( got.a === 1 );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapOwnFields( a );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.shouldBe( got.b === 1 );

  var got = _.mapOwnFields( new String );
  test.identical( got, {} );

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnFields( a );
  test.shouldBe( Object.keys( got ).length === 1 );
  test.identical( got.a, 1 );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnFields( a );
  test.shouldBe( Object.keys( got ).length === 1 );
  test.identical( got.a, 1 );

  /* enumerable : 0 */

  Object.defineProperty( a, 'y', { enumerable : 0, value : 3 } );
  var got = _.mapOwnFields.call( { enumerable : 0 }, a );
  test.shouldBe( Object.keys( got ).length === 3 )
  test.identical( got.a, 1 );
  test.identical( got.y, 3 );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnFields();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapOwnFields( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnFields( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapOwnFields.call( { x : 1 }, {} );
    });

  }

};

//

function mapAllFields( test )
{
  test.description = 'empty';

  var got = _.mapAllFields( {} );
  test.shouldBe( Object.keys( got ).length === 1 )
  test.identical( got.__proto__, {}.__proto__ );

  var got = _.mapAllFields( [] );
  test.shouldBe( Object.keys( got ).length === 2 )
  test.identical( got.__proto__, [].__proto__ );
  test.identical( got.length, 0 );

  //

  test.description = 'trivial';

  var got = _.mapAllFields( { a : 1, b : function(){} } );
  test.shouldBe( Object.keys( got ).length === 2 )
  test.shouldBe( got.a === 1 );
  test.shouldBe( got.__proto__ === {}.__proto__ );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapAllFields( a );
  console.log(got);
  test.shouldBe( Object.keys( got ).length === 3 )
  test.shouldBe( got.length === 0 );
  test.shouldBe( got.b === 1 );
  test.shouldBe( got.__proto__ === [].__proto__ );

  var str = new String;
  var got = _.mapAllFields( str );
  test.identical( got.length, 0 );
  test.identical( got.__proto__, str.__proto__);

  //

  test.description = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllFields( a );
  test.shouldBe( Object.keys( got ).length === 3 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.__proto__, b );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllFields( a );
  test.shouldBe( Object.keys( got ).length === 4 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );
  test.identical( got.__proto__, b );

  //

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapAllFields();
    });

    test.description = 'atomic';
    test.shouldThrowError( function()
    {
      _.mapAllFields( 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapAllFields( 'wrong argument' );
    });

    test.description = 'unknown option';
    test.shouldThrowError( function()
    {
      _.mapAllFields.call( { x : 1 }, {} );
    });

  }

};

//

function mapOnlyAtomics( test )
{
  test.description = 'emtpy';

  var got = _.mapOnlyAtomics( {} )
  test.identical( got, {} );

  test.description = 'atomics';

  var src =
  {
    a : null,
    b : undefined,
    c : 5,
    e : false,
    f : 'a',
    g : function(){},
    h : [ 1 ],
    i : new Date(),
    j : new ArrayBuffer( 5 )
  }
  var got = _.mapOnlyAtomics( src );
  var expected =
  {
    a : null,
    b : undefined,
    c : 5,
    e : false,
    f : 'a',
  }
  test.identical( got, expected );

  //

  test.description = 'only enumerable';
  var a = {};
  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } )
  var got = _.mapOnlyAtomics( a );
  test.identical( got, {} );

  //

  test.description = 'from prototype';
  var a = {};
  var b = { a : 1, c : function(){} };
  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  Object.setPrototypeOf( a, b );
  var got = _.mapOnlyAtomics( a );
  test.identical( got, { a : 1 } );

  if( Config.debug )
  {
    test.description = 'invalid arg type';
    test.shouldThrowError( function()
    {
      _.mapOnlyAtomics( [] )
    })
    test.description = 'no args';
    test.shouldThrowError( function()
    {
      _.mapOnlyAtomics()
    })
  }

}

//

function mapBut( test )
{

  test.description = 'a unique object';
  var got = _.mapBut( { a : 7, b : 13, c : 3 }, { a : 1, b : 1 } );
  var expected = { c : 3 };
  test.identical( got, expected );

  test.description = 'a unique object';
  var got = _.mapBut( { a : 7, b : 13, c : 3 }, { a : 1, b : 1 },{ a : 1, c : 1 } );
  var expected = {};
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapBut();
  });

  test.description = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapBut( [] );
  });

  test.description = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapBut( 'wrong arguments' );
  });

};

//

function mapOwnBut( test )
{

  test.description = 'an empty object';
  var got = _.mapOwnBut( {  } );
  var expected = {  };
  test.identical( got, expected );

  test.description = 'an object';
  var got = _.mapOwnBut( { a : 7, b : 13, c : 3 }, { a : 7, b : 13 } );
  var expected = { c : 3 };
  test.identical( got, expected );

  test.description = 'an object';
  var got = _.mapOwnBut( { a : 7, 'toString' : 5 }, { b : 33, c : 77 } );
  var expected = { a : 7 };
  test.identical( got, expected );

  /**/

  if( !Config.debug ) 
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnBut();
  });

  test.description = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapOwnBut( [  ] );
  });

  test.description = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnBut( 'wrong arguments' );
  });

}

//

function mapButConditional( test )
{

  test.description = 'an object';
  var got = _.mapButConditional( _.field.mapper.atomic, { a : 1, b : 'xxx', c : [ 1, 2, 3 ] } );
  var expected = {a: 1, b: "xxx"};
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapButConditional();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapButConditional( _.field.mapper.atomic );
    });

    test.description = 'second argument is wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapButConditional( _.field.mapper.atomic, [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapButConditional( 'wrong arguments' );
    });

  }

};

//

function mapScreens( test )
{

  test.description = 'test1';
  var got = _.mapScreens( { d : 'name', c : 33, a : 'abc' }, { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' });
  console.log(got);
  var expected = { a : "abc", c : 33, d : "name" };
  test.identical( got, expected );

  test.description = 'test2';
  var got = _.mapScreens( { d : 'name', c : 33, a : 'abc' }, { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' });
  console.log(got);
  var expected = { a : "abc", c : 33, d : "name" };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.mapScreens();
    });

    test.description = 'first argument is not an object-like';
    test.shouldThrowError( function()
    {
      _.mapScreens( 3, [] );
    });

    test.description = 'second argument is not an object-like';
    test.shouldThrowError( function()
    {
      _.mapScreens( [], '' );
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen( {} );
    });

    test.description = 'redundant arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen( [], [], {} );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen( 'wrong arguments' );
    });

  }
};

//

function mapScreen( test )
{


  test.description = 'an object'
  var got = _.mapScreen( { a : 13, b : 77, c : 3, d : 'name' }, { d : 'name', c : 33, a : 'abc' } );
  var expected = { a : "abc", c : 33, d : "name" };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen( {} );
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _.mapScreen( [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapScreen( 'wrong arguments' );
    });

  }

};

//

function _mapScreen( test )
{

  test.description = 'an object';
  var options = {};
  options.screenObjects = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Mikle' };
  options.srcObjects = { 'a' : 33, 'd' : 'name', 'name' : 'Mikle', 'c' : 33 };
  var got = _._mapScreen( options );
  var expected = { a : 33, c : 33, name : "Mikle" };
  test.identical( got, expected );

  test.description = 'an object2'
  var options = {};
  options.screenObjects = { a : 13, b : 77, c : 3, d : 'name' };
  options.srcObjects = { d : 'name', c : 33, a : 'abc' };
  var got = _._mapScreen( options );
  var expected = { a : "abc", c : 33, d : "name" };
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._mapScreen();
    });

    test.description = 'redundant arguments';
    test.shouldThrowError( function()
    {
      _._mapScreen( {}, 'wrong arguments' );
    });

    test.description = 'wrong type of array';
    test.shouldThrowError( function()
    {
      _._mapScreen( [] );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _._mapScreen( 'wrong arguments' );
    });

  }

};

//

function mapIdentical( test )
{

  test.description = 'same [ key, value ]';
  var got = _.mapIdentical( { a : 7, b : 13 }, { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.description = 'same [ key, value ] in the arrays';
  var got = _.mapIdentical( [ 'a', 7, 'b', 13 ], [ 'a', 7, 'b', 13 ] );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.mapIdentical();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapIdentical( {} );
    });

    test.description = 'too much arguments';
    test.shouldThrowError( function()
    {
      _.mapIdentical( {}, {}, 'redundant argument' );
    });

  }

};

//

function mapContain( test )
{

  test.description = 'first has same keys like second';
  var got = _.mapContain( { a : 7, b : 13, c : 15 }, { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.description = 'in the array';
  var got = _.mapContain( [ 'a', 7, 'b', 13, 'c', 15 ], [ 'a', 7, 'b', 13 ] );
  var expected = true;
  test.identical( got, expected );

  test.description = 'number of keys in first not equal';
  var got = _.mapContain( { a : 1 }, { a : 1, b : 2 } );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.mapContain();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapContain( {} );
    });

    test.description = 'too much arguments';
    test.shouldThrowError( function()
    {
      _.mapContain( {}, {}, 'redundant argument' );
    });

  }

};

//

function mapOwnKey( test )
{

  test.description = 'second argument is string';
  var got = _.mapOwnKey( { a : 7, b : 13 }, 'a' );
  var expected = true;
  test.identical( got, expected );

  test.description = 'second argument is object';
  var got = _.mapOwnKey( { a : 7, b : 13 }, Object.create( null ).a = 'a' );
  var expected = true;
  test.identical( got, expected );

  test.description = 'second argument is symbol';
  var symbol = Symbol( 'b' ), obj = { a : 7, [ symbol ] : 13 };
  var got = _.mapOwnKey( obj, symbol );
  var expected = true;
  test.identical( got, expected );

  test.description = 'false';
  var got = _.mapOwnKey( Object.create( { a : 7, b : 13 } ), 'a' );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( Config.debug )
  {

    test.description = 'no argument';
    test.shouldThrowError( function()
    {
      _.mapOwnKey();
    });

    test.description = 'few arguments';
    test.shouldThrowError( function()
    {
      _.mapOwnKey( {}, 'a', 'b' );
    });

    test.description = 'wrong type of key';
    test.shouldThrowError( function()
    {
      _.mapOwnKey( [], 1 );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.mapOwnKey( 1 );
    });

    test.description = 'wrong type of second argument';
    test.shouldThrowError( function()
    {
      _.mapOwnKey( {}, 13 );
    });

    test.description = 'wrong type of arguments';
    test.shouldThrowError( function()
    {
      _.mapOwnKey( '', 7 );
    });

  }

};

//

function mapHasAll( test )
{
  test.description = 'empty';
  var got = _.mapHasAll( {}, {} );
  test.shouldBe( got );

  test.description = 'screen empty';
  var got = _.mapHasAll( { a : 1 }, {} );
  test.shouldBe( got );

  test.description = 'same keys';
  var got = _.mapHasAll( { a : 1 }, { a : 2 } );
  test.shouldBe( got );

  test.description = 'has only one';
  var got = _.mapHasAll( { a : 1, b : 2, c :  3 }, { b : 2 } );
  test.shouldBe( got );

  test.description = 'has all';
  var got = _.mapHasAll( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( got );

  test.description = 'one is mising';
  var got = _.mapHasAll( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( !got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAll( a, { a : 1 } );
  test.shouldBe( got );

  var got = _.mapHasAll( a, a );
  test.shouldBe( got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasAll( src, screen );
  test.shouldBe( got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAll( a, { a : undefined } );
  test.shouldBe( got );

  var got = _.mapHasAll( { a : undefined }, { a : undefined } );
  test.shouldBe( got );

  test.description = 'src has toString on proto';
  var got = _.mapHasAll( {}, { toString : 1 } );
  test.shouldBe( got );

  test.description = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );
  var got = _.mapHasAll( a, { a : 1 } );
  test.shouldBe( got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAll( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAll( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapHasAll( {}, {}, {} );
    });
  }

}

//

function mapHasAny( test )
{
  test.description = 'empty';
  var got = _.mapHasAny( {}, {} );
  test.shouldBe( !got );

  test.description = 'screen empty';
  var got = _.mapHasAny( { a : 1 }, {} );
  test.shouldBe( !got );

  test.description = 'same keys';
  var got = _.mapHasAny( { a : 1 }, { a : 2 } );
  test.shouldBe( got );

  test.description = 'has only one';
  var got = _.mapHasAny( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.shouldBe( got );

  test.description = 'has all';
  var got = _.mapHasAny( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( got );

  test.description = 'one is mising';
  var got = _.mapHasAny( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( got );

  test.description = 'has no one';
  var got = _.mapHasAny( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.shouldBe( !got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAny( a, { a : 1 } );
  test.shouldBe( got );

  var got = _.mapHasAny( a, a );
  test.shouldBe( !got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasAny( src, screen );
  test.shouldBe( !got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAny( a, { a : undefined } );
  test.shouldBe( got );

  var got = _.mapHasAny( { a : undefined }, { a : undefined } );
  test.shouldBe( got );

  test.description = 'src has toString on proto';
  var got = _.mapHasAny( {}, { x : 1, toString : 1 } );
  test.shouldBe( got );

  test.description = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );
  var got = _.mapHasAny( a, { a : 1, x : 1 } );
  test.shouldBe( got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAny( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAny( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapHasAny( {}, {}, {} );
    });
  }

}

//

function mapHasNone( test )
{
  test.description = 'empty';
  var got = _.mapHasNone( {}, {} );
  test.shouldBe( got );

  test.description = 'screen empty';
  var got = _.mapHasNone( { a : 1 }, {} );
  test.shouldBe( got );

  test.description = 'same keys';
  var got = _.mapHasNone( { a : 1 }, { a : 2 } );
  test.shouldBe( !got );

  test.description = 'has only one';
  var got = _.mapHasNone( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.shouldBe( !got );

  test.description = 'has all';
  var got = _.mapHasNone( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( !got );

  test.description = 'one is mising';
  var got = _.mapHasNone( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( !got );

  test.description = 'has no one';
  var got = _.mapHasNone( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.shouldBe( got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasNone( a, { a : 1 } );
  test.shouldBe( !got );

  var got = _.mapHasNone( a, a );
  test.shouldBe( got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasNone( src, screen );
  test.shouldBe( got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasNone( a, { a : undefined } );
  test.shouldBe( !got );

  var got = _.mapHasNone( { a : undefined }, { a : undefined } );
  test.shouldBe( !got );

  test.description = 'src has toString on proto';
  var got = _.mapHasNone( {}, { x : 1, toString : 1 } );
  test.shouldBe( !got );

  test.description = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );

  var got = _.mapHasNone( a, { x : 1 } );
  test.shouldBe( got );

  var got = _.mapHasNone( a, { a : 1 } );
  test.shouldBe( !got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasNone( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasNone( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapHasNone( {}, {}, {} );
    });
  }

}

//

function mapOwnAll( test )
{
  test.description = 'empty';
  var got = _.mapOwnAll( {}, {} );
  test.shouldBe( got );

  test.description = 'screen empty';
  var got = _.mapOwnAll( { a : 1 }, {} );
  test.shouldBe( got );

  test.description = 'same keys';
  var got = _.mapOwnAll( { a : 1 }, { a : 2 } );
  test.shouldBe( got );

  test.description = 'has only one';
  var got = _.mapOwnAll( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.shouldBe( !got );

  test.description = 'has all';
  var got = _.mapOwnAll( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( got );

  test.description = 'one is mising';
  var got = _.mapOwnAll( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( !got );

  test.description = 'has no one';
  var got = _.mapOwnAll( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.shouldBe( !got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAll( a, { a : 1 } );
  test.shouldBe( got );

  var got = _.mapOwnAll( a, a );
  test.shouldBe( got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnAll( src, screen );
  test.shouldBe( got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAll( a, { a : undefined } );
  test.shouldBe( got );

  var got = _.mapOwnAll( { a : undefined }, { a : undefined } );
  test.shouldBe( got );

  test.description = 'src has toString on proto';
  var got = _.mapOwnAll( {}, { x : 1, toString : 1 } );
  test.shouldBe( !got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAll( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAll( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnAll( {}, {}, {} );
    });

    test.description = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAll( a,{ a : 1 } );
    });

    test.description = 'screen is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAll( { a : 1 }, a );
    });
  }

}

//

function mapOwnAny( test )
{
  test.description = 'empty';
  var got = _.mapOwnAny( {}, {} );
  test.shouldBe( !got );

  test.description = 'screen empty';
  var got = _.mapOwnAny( { a : 1 }, {} );
  test.shouldBe( !got );

  test.description = 'same keys';
  var got = _.mapOwnAny( { a : 1 }, { a : 2 } );
  test.shouldBe( got );

  test.description = 'has only one';
  var got = _.mapOwnAny( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.shouldBe( got );

  test.description = 'has all';
  var got = _.mapOwnAny( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( got );

  test.description = 'one is mising';
  var got = _.mapOwnAny( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( got );

  test.description = 'has no one';
  var got = _.mapOwnAny( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.shouldBe( !got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAny( a, { a : 1 } );
  test.shouldBe( got );

  var got = _.mapOwnAny( a, a );
  test.shouldBe( !got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnAny( src, screen );
  test.shouldBe( !got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAny( a, { a : undefined } );
  test.shouldBe( got );

  var got = _.mapOwnAny( { a : undefined }, { a : undefined } );
  test.shouldBe( got );

  test.description = 'src has toString on proto';
  var got = _.mapOwnAny( {}, { x : 1, toString : 1 } );
  test.shouldBe( !got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAny( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAny( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnAny( {}, {}, {} );
    });

    test.description = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAny( a,{ a : 1 } );
    });

    test.description = 'screen is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAny( { a : 1 }, a );
    });
  }

}

//

function mapOwnNone( test )
{
  test.description = 'empty';
  var got = _.mapOwnNone( {}, {} );
  test.shouldBe( got );

  test.description = 'screen empty';
  var got = _.mapOwnNone( { a : 1 }, {} );
  test.shouldBe( got );

  test.description = 'same keys';
  var got = _.mapOwnNone( { a : 1 }, { a : 2 } );
  test.shouldBe( !got );

  test.description = 'has only one';
  var got = _.mapOwnNone( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.shouldBe( !got );

  test.description = 'has all';
  var got = _.mapOwnNone( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.shouldBe( !got );

  test.description = 'one is mising';
  var got = _.mapOwnNone( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.shouldBe( !got );

  test.description = 'has no one';
  var got = _.mapOwnNone( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.shouldBe( got );

  test.description = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnNone( a, { a : 1 } );
  test.shouldBe( !got );

  var got = _.mapOwnNone( a, a );
  test.shouldBe( got );

  test.description = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnNone( src, screen );
  test.shouldBe( got );

  test.description = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnNone( a, { a : undefined } );
  test.shouldBe( !got );

  var got = _.mapOwnNone( { a : undefined }, { a : undefined } );
  test.shouldBe( !got );

  test.description = 'src has toString on proto';
  var got = _.mapOwnNone( {}, { x : 1, toString : 1 } );
  test.shouldBe( got );

  //

  if( Config.degub )
  {
    test.description = 'src is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnNone( 1, {} );
    });

    test.description = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnNone( {}, 1 );
    });

    test.description = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnNone( {}, {}, {} );
    });

    test.description = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( a,{ a : 1 } );
    });

    test.description = 'screen is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( { a : 1 }, a );
    });
  }

}

//

// function mapGroup( test )
// {
//
//   test.description = 'an empty object';
//   var got = _.mapGroup( [  ], { key : 'key1' } );
//   var expected = {  };
//   test.identical( got, expected );
//
//   test.description = 'first argument is an array';
//   var got = _.mapGroup( [ { key1 : 44, key2 : 77 }, { key1 : 33 } ], { key : 'key1' } );
//   var expected = { 33 : [ { key1 : 33 } ], 44 : [ { key1 : 44, key2 : 77 } ] };
//   test.identical( got, expected );
//
//   /**/
//
//   if( Config.debug )
//   {
//
//     test.description = 'no argument';
//     test.shouldThrowError( function()
//     {
//       _.mapGroup();
//     });
//
//     test.description = 'few arguments';
//     test.shouldThrowError( function()
//     {
//       _.mapGroup( [] );
//     });
//
//     test.description = 'first argument not wrapped into array';
//     test.shouldThrowError( function()
//     {
//       _.mapGroup( { key1 : 44, key2 : 77 }, { key1 : 33 } , { key : 'key1' } );
//     });
//
//     test.description = 'second argument is wrong';
//     test.shouldThrowError( function()
//     {
//       _.mapGroup( {  }, [  ] );
//     });
//
//     test.description = 'wrong type of arguments';
//     test.shouldThrowError( function()
//     {
//       _.mapGroup( 'wrong arguments' );
//     });
//
//   }
//
// };

// --
//
// --

var Self =
{

  name : 'MapTests',
  silencing : 1,

  tests :
  {

    // map tester

    mapIs : mapIs,

    // map move

    mapClone : mapClone,

    mapExtendConditional : mapExtendConditional,
    mapExtend : mapExtend,
    mapSupplement : mapSupplement,
    mapComplement : mapComplement,

    mapCopy : mapCopy,

    // map convert

    mapFirstPair : mapFirstPair,

    mapToArray : mapToArray,
    mapValWithIndex : mapValWithIndex,
    mapKeyWithIndex : mapKeyWithIndex,
    mapToStr : mapToStr,

    // map properties

    mapKeys : mapKeys,
    mapOwnKeys : mapOwnKeys,
    mapAllKeys : mapAllKeys,

    mapVals : mapVals,
    mapOwnVals : mapOwnVals,
    mapAllVals : mapAllVals,

    mapPairs : mapPairs,
    mapOwnPairs : mapOwnPairs,
    mapAllPairs : mapAllPairs,

    mapProperties : mapProperties,
    mapOwnProperties : mapOwnProperties,
    mapAllProperties : mapAllProperties,

    mapRoutines : mapRoutines,
    mapOwnRoutines : mapOwnRoutines,
    mapAllRoutines : mapAllRoutines,

    mapFields : mapFields,
    mapOwnFields : mapOwnFields,
    mapAllFields : mapAllFields,

    mapOnlyAtomics : mapOnlyAtomics,

    // map logic

    mapBut : mapBut,

    mapOwnBut : mapOwnBut,

    mapButConditional : mapButConditional,

    mapScreens : mapScreens,
    mapScreen : mapScreen,
    _mapScreen : _mapScreen,

    mapIdentical : mapIdentical,
    mapContain : mapContain,

    mapOwnKey : mapOwnKey,

    mapHasAll : mapHasAll,
    mapHasAny : mapHasAny,
    mapHasNone : mapHasNone,

    mapOwnAll : mapOwnAll,
    mapOwnAny : mapOwnAny,
    mapOwnNone : mapOwnNone,

    // mapGroup : mapGroup,

  }

}

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
