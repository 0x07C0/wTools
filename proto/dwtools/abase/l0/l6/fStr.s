( function _fString_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// decorator
// --

// class QuotePair
// {
//   constructor( elements )
//   {
//     this.elements = elements;
//     return this;
//   }
// }

//

function strQuote( o )
{

  if( !_.mapIs( o ) )
  o = { src : arguments[ 0 ], quote : arguments[ 1 ] };
  if( o.quote === undefined || o.quote === null )
  o.quote = strQuote.defaults.quote;
  _.assertMapHasOnly( o, strQuote.defaults );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( _.arrayIs( o.src ) )
  {
    let result = [];
    for( let s = 0 ; s < o.src.length ; s++ )
    result.push( _.strQuote({ src : o.src[ s ], quote : o.quote }) );
    return result;
  }

  let src = o.src;

  if( !_.primitiveIs( src ) )
  src = _.toStr( src );

  _.assert( _.primitiveIs( src ) );

  let result = o.quote + String( src ) + o.quote;

  return result;
}

strQuote.defaults =
{
  src : null,
  quote : '"',
}

//

function strUnquote( o )
{

  if( !_.mapIs( o ) )
  o = { src : arguments[ 0 ], quote : arguments[ 1 ] };
  if( o.quote === undefined || o.quote === null )
  o.quote = strUnquote.defaults.quote;
  _.assertMapHasOnly( o, strUnquote.defaults );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let result = o.src;
  let isolated = _.strIsolateInsideLeft( result, o.quote );
  if( isolated[ 0 ] === '' && isolated[ 4 ] === '' )
  result = isolated[ 2 ];

  return result;
}

strUnquote.defaults =
{
  src : null,
  quote : [ '"', '`', '\'' ],
}

//

function strQuotePairsNormalize( quote )
{

  if( ( _.boolLike( quote ) && quote ) )
  quote = strQuoteAnalyze.defaults.quote;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( quote ) || _.arrayIs( quote ) );

  quote = _.arrayAs( quote );
  for( let q = 0 ; q < quote.length ; q++ )
  {
    let quotingPair = quote[ q ];
    _.assert( _.pair.is( quotingPair ) || _.strIs( quotingPair ) );
    if( _.strIs( quotingPair ) )
    quotingPair = quote[ q ] = [ quotingPair, quotingPair ];
    _.assert( _.strIs( quotingPair[ 0 ] ) && _.strIs( quotingPair[ 1 ] ) );
  }

  return quote;
}

//

function strQuoteAnalyze( o )
{
  let i = -1;
  let result = Object.create( null );
  result.ranges = [];
  result.quotes = [];

  // if( !_.mapIs( o ) )
  // o = { src : o };
  // if( o.quote === undefined || o.quote === null )
  // o.quote = strQuoteAnalyze.defaults.quote;
  // _.assertMapHasOnly( o, strQuoteAnalyze.defaults );
  // _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( _.strIs( o.src ) );

  if( !_.mapIs( o ) )
  o = { src : arguments[ 0 ], quote : arguments[ 1 ] };
  if( o.quote === undefined || o.quote === null )
  o.quote = strQuoteAnalyze.defaults.quote;
  _.assertMapHasOnly( o, strQuoteAnalyze.defaults );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  o.quote = _.strQuotePairsNormalize( o.quote );
  let maxQuoteLength = 0;
  for( let q = 0 ; q < o.quote.length ; q++ )
  {
    let quotingPair = o.quote[ q ];
    maxQuoteLength = Math.max( maxQuoteLength, quotingPair[ 0 ].length, quotingPair[ 1 ].length );
  }

  let isEqual = maxQuoteLength === 1 ? isEqualChar : isEqualString;
  let inRange = false
  do
  {
    while( i < o.src.length )
    {
      i += 1;

      if( inRange )
      {
        if( isEqual( inRange ) )
        {
          result.ranges.push( i );
          inRange = false;
        }
        continue;
      }

      for( let q = 0 ; q < o.quote.length ; q++ )
      {
        let quotingPair = o.quote[ q ];
        if( isEqual( quotingPair[ 0 ] ) )
        {
          result.quotes.push( quotingPair[ 0 ] );
          result.ranges.push( i );
          inRange = quotingPair[ 1 ];
          break;
        }
      }
    }

    if( inRange )
    {
      result.quotes.pop();
      i = result.ranges.pop()+1;
      inRange = false;
    }

  }
  while( i < o.src.length );

  return result;

  function isEqualChar( quote )
  {
    _.assert( o.src.length >= i );
    if( o.src[ i ] === quote )
    return true;
    return false;
  }

  function isEqualString( quote )
  {
    if( i+quote.length > o.src.length )
    return false;
    let subStr = o.src.substring( i, i+quote.length );
    if( subStr === quote )
    return true;
    return false;
  }

}

strQuoteAnalyze.defaults =
{
  src : null,
  quote : [ '"', '`', '\'' ],
}

// --
//
// --

/* qqq : ask how to modify strLeft/strRight */

function _strLeftSingle( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );
  _.assert( _.strIs( src ) );
  _.assert( first === undefined || _.numberIs( first ) );
  _.assert( last === undefined || _.numberIs( last ) );

  ins = _.arrayAs( ins );

  let olength = src.length;
  let result = Object.create( null );
  result.index = olength;
  result.instanceIndex = -1;
  result.entry = undefined;

  if( first !== undefined || last !== undefined )
  {
    if( first === undefined )
    first = 0;
    if( last === undefined )
    last = src.length;
    if( first < 0 )
    first = src.length + first;
    if( last < 0 )
    last = src.length + last;
    // if( first >= src.length )
    // return result;
    // if( last <= -1 )
    // return result;
    _.assert( 0 <= first && first <= src.length );
    _.assert( 0 <= last && last <= src.length );
    src = src.substring( first, last );
  }

  for( let k = 0, len = ins.length ; k < len ; k++ )
  {
    let entry = ins[ k ];
    if( _.strIs( entry ) )
    {
      let found = src.indexOf( entry );
      if( found >= 0 && ( found < result.index || result.entry === undefined ) )
      {
        result.instanceIndex = k;
        result.index = found;
        result.entry = entry;
      }
    }
    else if( _.regexpIs( entry ) )
    {
      let found = src.match( entry );
      if( found && ( found.index < result.index || result.entry === undefined ) )
      {
        result.instanceIndex = k;
        result.index = found.index;
        result.entry = found[ 0 ];
      }
    }
    else _.assert( 0, 'Expects string-like ( string or regexp )' );
  }

  if( first !== undefined && result.index !== olength )
  result.index += first;

  return result;
}

//

function strLeft( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strLeftSingle( src[ s ], ins, first, last );
    return result;
  }
  else
  {
    return _._strLeftSingle( src, ins, first, last );
  }

}

//

/*

(bb)(?!(?=.).*(?:bb))
aa_bb_|bb|b_cc_cc

.*(bb)
aa_bb_b|bb|_cc_cc

(b+)(?!(?=.).*(?:b+))
aa_bb_|bb|_cc_cc

.*(b+)
aa_bb_bb|b|_cc_cc

*/

function _strRightSingle( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );
  _.assert( _.strIs( src ) );
  _.assert( first === undefined || _.numberIs( first ) );
  _.assert( last === undefined || _.numberIs( last ) );

  ins = _.arrayAs( ins );

  let olength = src.length;
  let result = Object.create( null );
  result.index = -1;
  result.instanceIndex = -1;
  result.entry = undefined;

  if( first !== undefined || last !== undefined )
  {
    if( first === undefined )
    first = 0;
    if( last === undefined )
    last = src.length;
    if( first < 0 )
    first = src.length + first;
    if( last < 0 )
    last = src.length + last;
    // if( first >= src.length )
    // return result;
    // if( last <= -1 )
    // return result;
    _.assert( 0 <= first && first <= src.length );
    _.assert( 0 <= last && last <= src.length );
    src = src.substring( first, last );
  }

  for( let k = 0, len = ins.length ; k < len ; k++ )
  {
    let entry = ins[ k ];
    if( _.strIs( entry ) )
    {
      let found = src.lastIndexOf( entry );
      if( found >= 0 && found > result.index )
      {
        result.instanceIndex = k;
        result.index = found;
        result.entry = entry;
      }
    }
    else if( _.regexpIs( entry ) )
    {

      let regexp1 = _.regexpsJoin([ '.*', '(', entry, ')' ]);
      let match1 = src.match( regexp1 );
      if( !match1 )
      continue;

      let regexp2 = _.regexpsJoin([ entry, '(?!(?=.).*', entry, ')' ]);
      let match2 = src.match( regexp2 );
      _.assert( !!match2 );

      let found;
      let found1 = match1[ 1 ];
      let found2 = match2[ 0 ];
      let index;
      let index1 = match1.index + match1[ 0 ].length;
      let index2 = match2.index + match2[ 0 ].length;

      if( index1 === index2 )
      {
        if( found1.length < found2.length )
        {
          // debugger;
          found = found2;
          index = index2 - found.length;
        }
        else
        {
          found = found1;
          index = index1 - found.length;
        }
      }
      else if( index1 < index2 )
      {
        found = found2;
        index = index2 - found.length;
      }
      else
      {
        found = found1;
        index = index1 - found.length;
      }

      if( index > result.index )
      {
        result.instanceIndex = k;
        result.index = index;
        result.entry = found;
      }

    }
    else _.assert( 0, 'Expects string-like ( string or regexp )' );
  }

  if( first !== undefined && result.index !== -1 )
  result.index += first;

  return result;
}

//

function strRight( src, ins, first, last )
{

  _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );

  if( _.arrayLike( src ) )
  {
    let result = [];
    for( let s = 0 ; s < src.length ; s++ )
    result[ s ] = _._strRightSingle( src[ s ], ins, first, last );
    return result;
  }
  else
  {
    return _._strRightSingle( src, ins, first, last );
  }

}

// //
//
// function _strCutOff_pre( routine, args )
// {
//   let o;
//
//   if( args.length > 1 )
//   {
//     o = { src : args[ 0 ], delimeter : args[ 1 ], number : args[ 2 ] };
//   }
//   else
//   {
//     o = args[ 0 ];
//     _.assert( args.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( routine, o );
//   _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( _.strIs( o.src ) );
//   _.assert( _.strIs( o.delimeter ) || _.arrayIs( o.delimeter ) );
//
//   return o;
// }

//

/**
 * Returns part of a source string( src ) between first occurrence of( begin ) and last occurrence of( end ).
 * Returns result if ( begin ) and ( end ) exists in source( src ) and index of( end ) is bigger the index of( begin ).
 * Otherwise returns undefined.
 *
 * @param { String } src - The source string.
 * @param { String } begin - String to find from begin of source.
 * @param { String } end - String to find from end source.
 *
 * @example
 * _.strInsideOf( 'abcd', 'a', 'd' );
 * // returns 'bc'
 *
 * @example
 * _.strInsideOf( 'aabcc', 'a', 'c' );
 * // returns 'aabcc'
 *
 * @example
 * _.strInsideOf( 'aabcc', 'a', 'a' );
 * // returns 'a'
 *
 * @example
 * _.strInsideOf( 'abc', 'a', 'a' );
 * // returns undefined
 *
 * @example
 * _.strInsideOf( 'abcd', 'x', 'y' )
 * // returns undefined
 *
 * @example
 * // index of begin is bigger then index of end
 * _.strInsideOf( 'abcd', 'c', 'a' )
 * // returns undefined
 *
 * @returns { string } Returns part of source string between ( begin ) and ( end ) or undefined.
 * @throws { Exception } If all arguments are not strings;
 * @throws { Exception } If ( argumets.length ) is not equal 3.
 * @function strInsideOf
 * @memberof wTools
 */

function strInsideOf( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let beginOf, endOf;

  beginOf = _.strBeginOf( src, begin );
  if( beginOf === false )
  return false;

  endOf = _.strEndOf( src, end );
  if( endOf === false )
  return false;

  let result = src.substring( beginOf.length, src.length - endOf.length );

  return result;
}

//

function strOutsideOf( src, begin, end )
{

  _.assert( _.strIs( src ), 'Expects string {-src-}' );
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  let beginOf, endOf;

  beginOf = _.strBeginOf( src, begin );
  if( beginOf === false )
  return false;

  endOf = _.strEndOf( src, end );
  if( endOf === false )
  return false;

  let result = beginOf + endOf;

  return result;
}

//

function strReplaceBegin( src, begin, ins )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( ins ), 'Expects {-ins-} as string' );
  _.assert( _.strIs( src ) );

  let result = src;
  if( _.strBegins( result , begin ) )
  {
    let prefix = ins;
    result = prefix + _.strRemoveBegin( result, begin );
  }

  return result;
}

//

function strReplaceEnd( src, end, ins )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( ins ), 'Expects {-ins-} as string' );
  _.assert( _.strIs( src ) );

  let result = src;
  if( _.strEnds( result, end ) )
  {
    let postfix = ins;
    result = _.strRemoveEnd( result , end ) + postfix;
  }

  return result;
}

//

function strReplace( srcStr, insStr, subStr )
{
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.strIs( srcStr ), 'Expects string {-src-}' );
  _.assert( _.strIs( subStr ), 'Expects string {-sub-}' );

  let result = srcStr;
  debugger;

  result = result.replace( insStr, subStr );

  return result;
}


// --
// fields
// --

let Fields =
{
  // QuotePair,
}

// --
// routines
// --

let Routines =
{

  // decorator

  strQuote, /* xxx : move up */
  strUnquote, /* xxx : move up */ /* qqq : cover please */
  strQuotePairsNormalize, /* qqq : cover please strQuotePairsNormalize | Dmytro : covered */
  strQuoteAnalyze, /* qqq : cover please | Dmytro : extended coverage */

  //

  _strLeftSingle,
  strLeft, /* qqq : improve coverage */
  _strRightSingle,
  strRight, /* qqq : improve coverage */

  strsEquivalentAll : _.vectorizeAll( _.strEquivalent, 2 ),
  strsEquivalentAny : _.vectorizeAny( _.strEquivalent, 2 ),
  strsEquivalentNone : _.vectorizeNone( _.strEquivalent, 2 ),

  strInsideOf,
  strOutsideOf,

  strReplaceBegin,
  strReplaceEnd,
  strReplace,

  /* qqq : check coverage of each routine of the file fString.s */

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
