( function _l3_Time_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// time
// --

function timerIs( src )
{
  if( !src )
  return false;
  return _.strIs( src.type ) && !!src.time && !!src.cancel;
}

//

function competitorIs( src )
{
  if( !src )
  return false;
  if( !_.mapIs( src ) )
  return false;
  return src.competitorRoutine !== undefined;
}

//

function dateIs( src )
{
  return Object.prototype.toString.call( src ) === '[object Date]';
}

//

function datesAreIdentical( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.dateIs( src1 ) )
  return false;
  if( !_.dateIs( src2 ) )
  return false;

  src1 = src1.getTime();
  src2 = src2.getTime();

  return src1 === src2;
}

// --
// fields
// --

let Fields =
{
}

// --
// routines
// --

let Routines =
{

  timerIs,
  competitorIs,

  dateIs,
  datesAreIdentical,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
