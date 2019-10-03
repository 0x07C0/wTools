( function _ContainerAdapter_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

var _ = wTools;

// --
// base tests
// --

function is( test )
{
  test.case = 'empty';
  var got = _.containerAdapter.is();
  test.identical( got, false );

  test.case = 'src - null';
  var got = _.containerAdapter.is( null );
  test.identical( got, false );

  test.case = 'src - undefined';
  var got = _.containerAdapter.is( undefined );
  test.identical( got, false );

  test.case = 'src - number';
  var got = _.containerAdapter.is( 1 );
  test.identical( got, false );

  test.case = 'src - string';
  var got = _.containerAdapter.is( 'str' );
  test.identical( got, false );

  test.case = 'src - boolean, true';
  var got = _.containerAdapter.is( true );
  test.identical( got, false );

  test.case = 'src - boolean, false';
  var got = _.containerAdapter.is( false );
  test.identical( got, false );

  test.case = 'src - array';
  var got = _.containerAdapter.is( [ 1, 2 ] );
  test.identical( got, false );

  test.case = 'src - unroll';
  var got = _.containerAdapter.is( _.unrollMake( [ 1, 2 ] ) );
  test.identical( got, false );

  test.case = 'src - argumentsArray';
  var got = _.containerAdapter.is( _.argumentsArrayMake( [ 1, 2 ] ) );
  test.identical( got, false );

  test.case = 'src - BufferRaw';
  var got = _.containerAdapter.is( new BufferRaw( 5 ) );
  test.identical( got, false );

  test.case = 'src - BufferTyped';
  var got = _.containerAdapter.is( new U8x( [ 1, 2 ] ) );
  test.identical( got, false );

  test.case = 'src - map';
  var got = _.containerAdapter.is( { a : 0 } );
  test.identical( got, false );

  test.case = 'src - Map';
  var got = _.containerAdapter.is( new Map() );
  test.identical( got, false );

  test.case = 'src - Set';
  var got = _.containerAdapter.is( new Set() );
  test.identical( got, false );

  test.case = 'src - Symbol';
  var got = _.containerAdapter.is( Symbol( 'a' ) );
  test.identical( got, false );

  test.case = 'src - instance of constructor';
  function Constr()
  {
    this.x = 1;
    return this;
  }
  var got = _.containerAdapter.is( new Constr() );
  test.identical( got, false );

  /* */

  test.case = 'check instance of ContainerAdapter';
  var src = _.containerAdapter.make( [ 1, 2 ] );
  var got = _.containerAdapter.is( src );
  test.identical( got, true );

  test.case = 'check instance of ContainerAdapter';
  var src = _.containerAdapter.make( new Set( [ 1, 2 ] ) );
  var got = _.containerAdapter.is( src );
  test.identical( got, true );
}

//

function make( test )
{
  test.case = 'from empty array';
  var src = [];
  var exp = _.containerAdapter.make( [] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from array';
  var src = [ 1, 2, '', {}, [], null, undefined ];
  var exp = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty unroll';
  var src = _.unrollMake( [] );
  var exp = _.containerAdapter.make( [] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from unroll';
  var src = _.unrollMake( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty Set';
  var src = new Set();
  var exp = _.containerAdapter.make( new Set() );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from Set';
  var src = new Set( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty arrayAdapterContainer';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from arrayAdapterContainer';
  var src = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty setAdapterContainer';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from setAdapterContainer';
  var src = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.make( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.containerAdapter.make( [ 1, 2 ], [ 1, 2 ] ) );

  test.case = 'container is not an array or a set';
  test.shouldThrowErrorSync( () => _.containerAdapter.make( _.argumentsArrayMake( 10 ) ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( new U8x( 10 ) ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( { a : 0 } ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( 'str' ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( 0 ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( null ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.make( undefined ) );
}

//

function from( test )
{
  test.case = 'from empty array';
  var src = [];
  var exp = _.containerAdapter.from( [] );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from array';
  var src = [ 1, 2, '', {}, [], null, undefined ];
  var exp = _.containerAdapter.from( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty unroll';
  var src = _.unrollFrom( [] );
  var exp = _.containerAdapter.from( [] );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from unroll';
  var src = _.unrollFrom( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.from( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty Set';
  var src = new Set();
  var exp = _.containerAdapter.from( new Set() );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from Set';
  var src = new Set( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.from( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.from( src );
  test.is( got !== src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty arrayAdapterContainer';
  var src = _.containerAdapter.from( [] );
  var exp = _.containerAdapter.from( [] );
  var got = _.containerAdapter.from( src );
  test.is( got === src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from arrayAdapterContainer';
  var src = _.containerAdapter.from( [ 1, 2, '', {}, [], null, undefined ] );
  var exp = _.containerAdapter.from( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.from( src );
  test.is( got === src );
  test.is( _.arrayIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from empty setAdapterContainer';
  var src = _.containerAdapter.from( new Set( [] ) );
  var exp = _.containerAdapter.from( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.from( src );
  test.is( got === src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  test.case = 'from setAdapterContainer';
  var src = _.containerAdapter.from( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var exp = _.containerAdapter.from( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.from( src );
  test.is( got === src );
  test.is( _.setIs( got.original ) );
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.containerAdapter.from( [ 1, 2 ], [ 1, 2 ] ) );

  test.case = 'container is not an array or a set';
  test.shouldThrowErrorSync( () => _.containerAdapter.from( _.argumentsArrayfrom( 10 ) ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( new U8x( 10 ) ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( { a : 0 } ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( 'str' ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( 0 ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( null ) );
  test.shouldThrowErrorSync( () => _.containerAdapter.from( undefined ) );
}

//

function toOriginal( test )
{
  test.case = 'empty';
  var exp = undefined;
  var got = _.containerAdapter.toOriginal();
  test.identical( got, exp );

  test.case = 'from null';
  var src = null;
  var exp = null;
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from undefined';
  var src = undefined;
  var exp = undefined;
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from number';
  var src = 5;
  var exp = 5;
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from string';
  var src = 'str';
  var exp = 'str';
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from boolean';
  var src = true;
  var exp = true;
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from array';
  var src = [ 1, 2, 'str' ];
  var exp = [ 1, 2, 'str' ];
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from unroll';
  var src = _.unrollMake( [ 1, 2, 'str' ] );
  var exp = _.unrollMake( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var exp = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from BufferRaw';
  var src = new BufferRaw( [ 1, 2, 'str' ] );
  var exp = new BufferRaw( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from BufferTyped';
  var src = new I16x( [ 1, 2, 'str' ] );
  var exp = new I16x( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from map';
  var src = { a : 0 };
  var exp = { a : 0 };
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from Map';
  var src = new Map( [ [ 1, 2 ] ] );
  var exp = new Map( [ [ 1, 2 ] ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );

  test.case = 'from Set';
  var src = new Set();
  var exp = new Set();
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( [ ... got ], [ ... exp ] );

  test.case = 'from Symbol';
  var src = Symbol( 'a' );
  var exp = src;
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from instance of constructor';
  function Constr()
  {
    this.x = 1;
    return this;
  }
  var src = new Constr();
  var exp = new Constr();
  var got = _.containerAdapter.toOriginal( src );
  test.is( got === src );
  test.identical( got, exp );

  /* */

  test.case = 'from ArrayContainerAdapter';
  var src = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got !== src );
  test.identical( got, src.original );

  test.case = 'from SetContainerAdapter';
  var src = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.toOriginal( src );
  test.is( got !== src );
  test.identical( got, src.original );
}

//

function toOriginals( test )
{
  test.open( 'dsts not arrayLike' );

  test.case = 'empty';
  var exp = undefined;
  var got = _.containerAdapter.toOriginals();
  test.identical( got, exp );

  test.case = 'from null';
  var src = null;
  var exp = null;
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from null';
  var src = null;
  var exp = null;
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from undefined';
  var src = undefined;
  var exp = undefined;
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from undefined';
  var src = undefined;
  var exp = null;
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from number';
  var src = 5;
  var exp = 5;
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from number';
  var src = 5;
  var exp = [ 5 ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from string';
  var src = 'str';
  var exp = 'str';
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from string';
  var src = 'str';
  var exp = [ 'str' ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from boolean';
  var src = true;
  var exp = true;
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from boolean';
  var src = true;
  var exp = [ true ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from array';
  var src = [ 1, 2, 'str' ];
  var exp = [ 1, 2, 'str' ];
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from array';
  var src = [ 1, 2, 'str' ];
  var exp = [ 1, 2, 'str' ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from empty array';
  var src = [];
  var exp = [];
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from empty array';
  var src = [];
  var exp = [];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from unroll';
  var src = _.unrollMake( [ 1, 2, 'str' ] );
  var exp = _.unrollMake( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from unroll';
  var src = _.unrollMake( [ 1, 2, 'str' ] );
  var exp = _.unrollMake( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var exp = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var exp = [ 1, 2, 'str' ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from BufferRaw';
  var src = new BufferRaw( [ 1, 2, 'str' ] );
  var exp = new BufferRaw( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from BufferRaw';
  var src = new BufferRaw( [ 1, 2, 'str' ] );
  var exp = [ new BufferRaw( [ 1, 2, 'str' ] ) ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from BufferTyped';
  var src = new I16x( [ 1, 2, 'str' ] );
  var exp = new I16x( [ 1, 2, 'str' ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from map';
  var src = { a : 0 };
  var exp = { a : 0 };
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'dsts - null, from map';
  var src = { a : 0 };
  var exp = [ { a : 0 } ];
  var got = _.containerAdapter.toOriginals( null, src );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'from Map';
  var src = new Map( [ [ 1, 2 ] ] );
  var exp = new Map( [ [ 1, 2 ] ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  //
  // test.case = 'dsts - null, from Map';
  // var src = new Map( [ [ 1, 2 ] ] );
  // var exp = new Map( [ [ 1, 2 ] ] );
  // var got = _.containerAdapter.toOriginals( null, src );
  // test.is( got === src );
  // test.identical( [ got[ 0 ].entries() ], [ ... exp.entries() ] );

  test.case = 'from Set';
  var src = new Set();
  var exp = new Set();
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( [ ... got ], [ ... exp ] );

  // test.case = 'dsts - null, from Set';
  // var src = new Set();
  // var exp = new Set();
  // var got = _.containerAdapter.toOriginals( null, src );
  // test.is( got === src );
  // test.identical( [ ... got ], [ ... exp ] );

  test.case = 'from Symbol';
  var src = Symbol( 'a' );
  var exp = src;
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.case = 'from instance of constructor';
  function Constr()
  {
    this.x = 1;
    return this;
  }
  var src = new Constr();
  var exp = new Constr();
  var got = _.containerAdapter.toOriginals( src );
  test.is( got === src );
  test.identical( got, exp );

  test.close( 'dsts not arrayLike' );

  /* */

  test.case = 'from ArrayContainerAdapter';
  var src = _.containerAdapter.make( [ 1, 2, '', {}, [], null, undefined ] );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got !== src );
  test.identical( got, src.original );

  test.case = 'from SetContainerAdapter';
  var src = _.containerAdapter.make( new Set( [ 1, 2, '', {}, [], null, undefined ] ) );
  var got = _.containerAdapter.toOriginals( src );
  test.is( got !== src );
  test.identical( got, src.original );

  /* */

  test.case = 'array contains ArrayContainerAdapter';
  var src = _.containerAdapter.make( [ 1, 2, 'str' ] );
  var srcs = [ src, 1, src, 'str', src, undefined, null, false ];
  var got = _.containerAdapter.toOriginals( srcs );
  test.is( got === srcs );
  test.identical( got.length, 8 );
  test.identical( got[ 0 ], src.original );
  test.identical( got[ 2 ], src.original );

  test.case = 'array contains SetContainerAdapter';
  var src = _.containerAdapter.make( new Set( [ 1, 2, 'str' ] ) );
  var srcs = [ src, 1, src, 'str', src, undefined, null, false ];
  var got = _.containerAdapter.toOriginals( srcs );
  test.is( got === srcs );
  test.identical( got.length, 8 );
  test.identical( [ ... got[ 0 ] ], [ ... src.original ] );
  test.identical( [ ... got[ 2 ] ], [ ... src.original ] );

  test.case = 'array contains ArrayContainerAdapter and SetContainerAdapter';
  var src1 = _.containerAdapter.make( [ 1, 2, 'str' ] );
  var src2 = _.containerAdapter.make( new Set( [ 1, 2, 'str' ] ) );
  var srcs = [ src1, 1, src2, 'str', src1, undefined, null, false ];
  var got = _.containerAdapter.toOriginals( srcs );
  test.is( got === srcs );
  test.identical( got.length, 8 );
  test.identical( got[ 0 ], src1.original );
  test.identical( [ ... got[ 2 ] ], [ ... src2.original ] );
}

//--
// SetContainerAdapter
//--

function setAdapterMap( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.map( null );
  test.is( got !== src );
  test.identical( got, exp );

  /* - */

  test.open( 'only onEach' );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.map( ( e ) => 123 );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.map( ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] ) );
  var got = src.map( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'only onEach' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'from array, onEach returns container';
  var src = _.containerAdapter.make( new Set( [ 1 ] ) );
  var exp = [ ... new Set( [ 1 ] ) ];
  var got = src.map( null, ( e, k, src ) => src );
  test.is( got !== src );
  test.identical( Array.from( ... got.original ),  exp );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( null, ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( null, ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.map( null, ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] ) );
  var got = src.map( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'from empty array, onEach returns container';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.map( src, ( e, k, src ) => src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( src, ( e ) => e );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.map( src, ( e ) => undefined );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.map( src, ( e ) => [ e ] );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] ) );
  var got = src.map( src, ( e ) => e[ 0 ] );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === src' );
}

//

function setAdapterFilter( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( null );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  /* - */

  test.open( 'only onEach' );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( ( e ) => 123 );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] ) );
  var got = src.filter( ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.filter( ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 2 ] ) );
  var got = src.filter( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'only onEach' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'from array, onEach returns container';
  var src = _.containerAdapter.make( new Set( [ 1 ] ) );
  var exp = [ src ];
  var got = src.filter( null, ( e, k, src ) => src );
  test.is( got !== src );
  test.identical( [ ... got.original ], exp );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] ) );
  var got = src.filter( null, ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( null, ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.filter( null, ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 2 ] ) );
  var got = src.filter( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'from empty array, onEach returns container';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( src, ( e, k, src ) => src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] ) );
  var got = src.filter( src, ( e ) => e );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.filter( src, ( e ) => undefined );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] ) );
  var got = src.filter( src, ( e ) => [ e ] );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 2 ] ) );
  var got = src.filter( src, ( e ) => e[ 0 ] );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === src' );
}

//

function setAdapterOnce( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  /* - */

  test.open( 'only onEval' );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( new Set( [ 0, 0, 1, 1, null, true, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( ( e, e2 ) => e === e2 );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval remove undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0 ] ) );
  var got = src.once( ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'only onEval' );

  /* - */

  test.open( 'only dst' );

  test.case = 'src - from empty array, dst - empty ArrayContainerAdapter, no onEval';
  var src = _.containerAdapter.make( new Set( [] ) );
  var dst = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'the same containers, onEval returns element';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var dst = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, [ 2 ], { a : 0 } ] ) );
  var got = src.once( dst, ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'the same containers, onEval is simple equalizer';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var dst = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, new U8x( 2 ) ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, new U8x( 2 ), [ 2 ], { a : 0 } ] ) );
  var got = src.once( dst, ( e, e2 ) => e === e2 );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'different containers, onEval remove undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var dst = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( dst, ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var dst = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 }, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( dst, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array, duplicates in src';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], [ true ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var dst = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 }, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( dst, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'only dst' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'src - from empty array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'src - from empty array, dst - empty ArrayContainerAdapter, no onEval';
  var src = _.containerAdapter.make( new Set( [] ) );
  var dst = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( got, exp );

  test.case = 'src - from array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( new Set( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, null, undefined, false ] ) );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'src - from array, append array, no onEval';
  var src = _.containerAdapter.make( new Set( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, null, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] ) );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( null, ( e ) => e );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( null, ( e, e2 ) => e === e2 );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval remove undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0 ] ) );
  var got = src.once( null, ( e ) => undefined );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array, duplicates in src';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], [ true ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'src - from empty array, no onEval';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'src - from empty array, no onEval';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = _.containerAdapter.make( new Set( [] ) );
  var got = src.once( src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'src - from array, no onEval';
  var src = _.containerAdapter.make( new Set( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, null, undefined, false ] ) );
  var got = src.once( src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'src - from array, no onEval';
  var src = _.containerAdapter.make( new Set( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] ) );
  var exp = _.containerAdapter.make( new Set( [ 1, 2, null, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] ) );
  var got = src.once( src );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( src, ( e ) => e );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var got = src.once( src, ( e, e2 ) => e === e2 );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'different containers, onEval remove undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0 ] ) );
  var got = src.once( src, ( e ) => undefined );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( new Set( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = _.containerAdapter.make( new Set( [ 0, [ null ], [ true ], [ 2 ] ] ) );
  var got = src.once( src, ( e ) => e[ 0 ] );
  test.is( got === src );
  test.identical( [ ... got.original ], [ ... exp.original ] );

  test.close( 'dst === src' );
}

//

function setAdapterEach( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e ) );
  test.is( got === src );
  test.identical( [ ... got.original ], exp );
  test.identical( exp, [] );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( new Set( [] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( 123 ) );
  test.is( got === src );
  test.identical( [ ... got.original ], exp );
  test.identical( exp, [] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e ) );
  test.is( got === src );
  test.identical( [ ... got.original ], exp );
  test.identical( exp, [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( undefined ) );
  test.is( got === src );
  test.identical( [ ... got.original ], [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( [ e ] ) );
  test.is( got === src );
  test.identical( [ ... got.original ], [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( new Set( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] ) );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e[ 0 ] ) );
  test.is( got === src );
  test.identical( [ ... got.original ], [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2, undefined ] );
}

//--
// ArrayContainerAdapter
//--

function arrayAdapterMap( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.map( null );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  /* - */

  test.open( 'only onEach' );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.map( ( e ) => 123 );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.map( ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] );
  var got = src.map( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'only onEach' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'from array, onEach returns container';
  var src = _.containerAdapter.make( [ 1 ] );
  var exp = _.containerAdapter.make( [ src ] );
  var got = src.map( null, ( e, k, src ) => src );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( null, ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( null, ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.map( null, ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [  0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] );
  var got = src.map( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'from empty array, onEach returns container';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.map( src, ( e, k, src ) => src );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( src, ( e ) => e );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.map( src, ( e ) => undefined );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.map( src, ( e ) => [ e ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', 2, { a : 0 } ] );
  var got = src.map( src, ( e ) => e[ 0 ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.close( 'dst === src' );
}

//

function arrayAdapterFilter( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( null );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  /* - */

  test.open( 'only onEach' );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( ( e ) => 123 );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] );
  var got = src.filter( ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.filter( ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 2 ] );
  var got = src.filter( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'only onEach' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'from array, onEach returns container';
  var src = _.containerAdapter.make( [ 1 ] );
  var exp = _.containerAdapter.make( [ src ] );
  var got = src.filter( null, ( e, k, src ) => src );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] );
  var got = src.filter( null, ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( null, ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.filter( null, ( e ) => [ e ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 2 ] );
  var got = src.filter( null, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'from empty array, onEach returns container';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( src, ( e, k, src ) => src );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, '', [ 2 ], { a : 0 } ] );
  var got = src.filter( src, ( e ) => e );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [] );
  var got = src.filter( src, ( e ) => undefined );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );
  var got = src.filter( src, ( e ) => [ e ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 2 ] );
  var got = src.filter( src, ( e ) => e[ 0 ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.close( 'dst === src' );
}

//

function arrayAdapterOnce( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.once( null );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  /* - */

  test.open( 'only onEval' );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( [ 0, 0, 1, 1, null, true, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( ( e, e2 ) => e === e2 );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval remove undefined';
  var src = _.containerAdapter.make( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0 ] );
  var got = src.once( ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, [ null ], [ true ], [ 2 ] ] );
  var got = src.once( ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'only onEval' );

  /* - */

  test.open( 'only dst' );

  test.case = 'src - from empty array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( [] );
  var dst = [];
  var exp = _.containerAdapter.make( [] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from empty array, dst - empty ArrayContainerAdapter, no onEval';
  var src = _.containerAdapter.make( [] );
  var dst = _.containerAdapter.make( [] );
  var exp = _.containerAdapter.make( [] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from empty array, dst - array, no onEval';
  var src = _.containerAdapter.make( [] );
  var dst = [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ];
  var exp = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var dst = [];
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false ] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, append array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  var dst = [ 1, 2, null, undefined, false ];
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'the same containers, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var dst = [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ];
  var exp = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var got = src.once( dst );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'the same containers, onEval returns element';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var dst = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, [ 2 ], { a : 0 } ] );
  var got = src.once( dst, ( e ) => e );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'the same containers, onEval is simple equalizer';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var dst = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, new U8x( 2 ) ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 }, new U8x( 2 ), [ 2 ], { a : 0 } ] );
  var got = src.once( dst, ( e, e2 ) => e === e2 );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'different containers, onEval remove undefined';
  var src = _.containerAdapter.make( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var dst = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( dst, ( e ) => undefined );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var dst = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var got = src.once( dst, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array, duplicates in src';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], [ true ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var dst = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var got = src.once( dst, ( e ) => e[ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'only dst' );

  /* - */

  test.open( 'dst === null' );

  test.case = 'src - from empty array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( [] );
  var got = src.once( null );
  var exp = _.containerAdapter.make( [] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from empty array, dst - empty ArrayContainerAdapter, no onEval';
  var src = _.containerAdapter.make( [] );
  var dst = _.containerAdapter.make( [] );
  var got = src.once( dst );
  var exp = _.containerAdapter.make( [] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, dst - empty array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var got = src.once( null );
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, append array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  var got = src.once( null );
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( null, ( e ) => e );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( null, ( e, e2 ) => e === e2 );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );


  test.case = 'onEval remove undefined';
  var src = _.containerAdapter.make( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( null, ( e ) => undefined );
  var exp = _.containerAdapter.make( [ 0 ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var got = src.once( null, ( e ) => e[ 0 ] );
  var exp = _.containerAdapter.make( [ 0, [ null ], [ true ], [ 2 ] ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array, duplicates in src';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], [ true ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var got = src.once( null, ( e ) => e[ 0 ] );
  var exp = _.containerAdapter.make( [ 0, [ null ], [ true ], [ 2 ] ] );
  test.is( got !== src );
  test.identical( got.original, exp.original );

  test.close( 'dst === null' );

  /* - */

  test.open( 'dst === src' );

  test.case = 'src - from empty array, no onEval';
  var src = _.containerAdapter.make( [] );
  var got = src.once( src );
  var exp = _.containerAdapter.make( [] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'src - from empty array, no onEval';
  var src = _.containerAdapter.make( [] );
  var got = src.once( src );
  var exp = _.containerAdapter.make( [] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false ] );
  var got = src.once( src );
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'src - from array, no onEval';
  var src = _.containerAdapter.make( [ 1, 2, 1, 2, null, null, undefined, false, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  var got = src.once( src );
  var exp = _.containerAdapter.make( [ 1, 2, null, undefined, false, [ 2 ], [ 2 ], [ 2 ] ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'onEval returns element';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( src, ( e ) => e );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'onEval is simple equalizer';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( src, ( e, e2 ) => e === e2 );
  var exp = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'different containers, onEval remove undefined';
  var src = _.containerAdapter.make( [ 0, 0, 1, 1, undefined, undefined, undefined, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var got = src.once( src, ( e ) => undefined );
  var exp = _.containerAdapter.make( [ 0 ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.case = 'onEval check element of array, no duplicates in src';
  var src = _.containerAdapter.make( [ 0, 1, [ null ], [ true ], false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var got = src.once( src, ( e ) => e[ 0 ] );
  var exp = _.containerAdapter.make( [ 0, [ null ], [ true ], [ 2 ] ] );
  test.is( got === src );
  test.identical( got.original, exp.original );

  test.close( 'dst === src' );
}

//

function arrayAdapterEach( test )
{
  test.case = 'without arguments';
  var src = _.containerAdapter.make( [] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e ) );
  test.is( got === src );
  test.identical( got.original, exp );
  test.identical( exp, [] );

  test.case = 'from empty array, onEach returns number';
  var src = _.containerAdapter.make( [] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( 123 ) );
  test.is( got === src );
  test.identical( got.original, exp );
  test.identical( exp, [] );

  test.case = 'from array, onEach returns original';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e ) );
  test.is( got === src );
  test.identical( got.original, exp );
  test.identical( exp, [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );

  test.case = 'from array, onEach returns undefined';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( undefined ) );
  test.is( got === src );
  test.identical( got.original, [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ] );

  test.case = 'from array, onEach returns array';
  var src = _.containerAdapter.make( [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( [ e ] ) );
  test.is( got === src );
  test.identical( got.original, [ 0, 1, null, true, false, undefined, '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ [ 0 ], [ 1 ], [ null ], [ true ], [ false ], [ undefined ], [ '' ], [ [ 2 ] ], [ { a : 0 } ] ] );

  test.case = 'from array, onEach returns element of array';
  var src = _.containerAdapter.make( [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  var exp = [];
  var got = src.each( ( e ) => exp.push( e[ 0 ] ) );
  test.is( got === src );
  test.identical( got.original, [ 0, 1, NaN, true, false, [ undefined ], '', [ 2 ], { a : 0 } ] );
  test.identical( exp, [ undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2, undefined ] );
}

// --
// declaration
// --

var Self =
{

  name : 'Tools.base.ContainerAdapter',
  silencing : 1,

  tests :
  {
    // containerAdapter

    is,
    make,
    from,
    toOriginal,
    toOriginals,

    // SetContainerAdapter

    setAdapterMap,
    setAdapterFilter,
    setAdapterOnce,
    setAdapterEach,

    // ArrayContainerAdapter

    arrayAdapterMap,
    arrayAdapterFilter,
    arrayAdapterOnce,
    arrayAdapterEach,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
