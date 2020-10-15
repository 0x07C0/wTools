( function _iProcess_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _.process = _.process || Object.create( null );

// --
//
// --

function on( o )
{

  o = _.event.on.head( _.event.on, arguments );
  _.event.on( _.process._ehandler, o );

  return o;
}

on.defaults =
{
  callbackMap : null,
}

//

function off( o )
{

  o = _.event.off.head( _.event.off, arguments );
  _.event.off( _.process._ehandler, o );

  return o;
}

off.defaults =
{
  callbackMap : null,
}

//

function hasEventHandler( o )
{
  o = _.event.hasEventHandler.head( _.event.hasEventHandler, arguments );
  return _.event.hasEventHandler( _.process._ehandler, o );
}

hasEventHandler.defaults =
{
  eventName : null,
  eventHandler : null,
}

//

let Inspector = null;
function isDebugged()
{
  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( typeof process === 'undefined' )
  return false;

  if( Inspector === null )
  try
  {
    Inspector = require( 'inspector' );
  }
  catch( err )
  {
    Inspector = false;
  }

  if( Inspector )
  return _.strIs( Inspector.url() );

  if( !process.execArgv.length )
  return false;

  let execArgvString = process.execArgv.join();
  return _.strHasAny( execArgvString, [ '--inspect', '--inspect-brk', '--debug-brk' ] );
}

//

function insideTestContainer()
{
  if( !_global_.process )
  return false;
  return 'CI' in _global_.process.env;
}

//

function entryPointStructure()
{
  let result = Object.create( null );
  if( _global.process !== undefined )
  {
    if( _global.process.argv )
    result.execPath = _global.process.argv.join( ' ' );
    if( _.routineIs( _global.process.cwd ) )
    result.currentPath = _global.process.cwd();
  }
  return result;
}

//

function entryPointInfo()
{
  let data = _.process.entryPointStructure();
  let result = '';

  if( data.currentPath )
  result = join( 'Current path', data.currentPath );
  if( data.execPath )
  result = join( 'Exec path', data.execPath );

  return result;

  /* */

  function join( left, right )
  {
    if( result )
    result += '\n';
    result += left + ' : ' + right;
    return result;
  }
}

// --
// routines
// --

let Events =
{
  'available' : [],
  'uncaughtError' : [],
  /* qqq :

  */
}

let _ehandler =
{
  events : Events,
}

let Extension =
{

  _ehandler,

  on,
  off,
  hasEventHandler, /* xxx : rename */

  // checker

  isDebugged,
  insideTestContainer,

  // entry point

  entryPointStructure,
  entryPointInfo,

}

//

Object.assign( _.process, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
