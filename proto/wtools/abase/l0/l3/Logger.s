( function _l3_Logger_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
const Self = _.logger = _.logger || Object.create( null );

// --
// implementation
// --

function consoleIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( console.Console )
  if( src && src instanceof console.Console )
  return true;

  if( src !== console )
  return false;

  let result = Object.prototype.toString.call( src );
  if( result === '[object Console]' || result === '[object Object]' )
  return true;

  return false;
}

//

function is( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.Logger )
  return false;

  if( src instanceof _.Logger )
  return true;

  return false;
}

//

function like( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.printer.is( src ) )
  return true;

  if( _.consoleIs( src ) )
  return true;

  if( src === _global_.logger )
  return true;

  return false;
}

//

function fromStrictly( src )
{
  let result = src;

  _.assert( result === null || _.boolIs( result ) || _.numberIs( result ) || _.logger.is( result ) );

  if( result === null )
  {
    result = new _.Logger({ output : _global_.logger, verbosity : 1 });
  }
  else if( _.boolIs( result ) )
  {
    result = new _.Logger({ output : _global_.logger, verbosity : result ? 1 : 0 });
  }
  else if( _.numberIs( result ) )
  {
    result = new _.Logger({ output : _global_.logger, verbosity : result });
  }
  else if( _.logger.is( result ) )
  {
  }
  else _.assert( 0 );

  return result;
}

//

function maybe( src )
{
  let result = src;

  _.assert( result === null || _.boolIs( result ) || _.numberIs( result ) || _.logger.is( result ) );

  if( result === null )
  {
    result = new _.Logger({ output : _global_.logger, verbosity : 1 });
  }
  else if( _.boolIs( result ) )
  {
    if( result )
    result = new _.Logger({ output : _global_.logger, verbosity : 1 });
    else
    result = false;
  }
  else if( _.numberIs( result ) )
  {
    if( result > 0 )
    result = new _.Logger({ output : _global_.logger, verbosity : result });
    else
    result = false;
  }
  else if( _.logger.is( result ) )
  {
  }
  else _.assert( 0 );

  return result;
}

//

function relativeMaybe( src, delta )
{
  let result = src;

  _.assert( result === null || _.boolIs( result ) || _.numberIs( result ) || _.logger.is( result ) );
  _.assert( delta === undefined || _.numberDefined( delta ) || _.logger.like( delta ) );

  if( _.logger.like( delta ) )
  return delta;

  delta = delta || 0;

  if( result === null )
  {
    result = new _.Logger({ output : _global_.logger, verbosity : 1 + delta });
  }
  else if( _.boolIs( result ) )
  {
    if( result )
    result = new _.Logger({ output : _global_.logger, verbosity : 1 + delta });
    else if( delta > 0 )
    result = new _.Logger({ output : _global_.logger, verbosity : delta });
    else
    result = false;
  }
  else if( _.numberIs( result ) )
  {
    result += delta;
    if( result > 0 )
    result = new _.Logger({ output : _global_.logger, verbosity : result });
    else
    result = false;
  }
  else if( _.logger.is( result ) )
  {
    if( delta !== 0 )
    result = new _.Logger({ output : result, verbosity : result.verbosity + delta });
  }
  else _.assert( 0 );

  return result;
}

//

function absoluteMaybe( src, verbosity )
{
  let result = src;

  _.assert( result === null || _.boolIs( result ) || _.numberIs( result ) || _.logger.is( result ) );
  _.assert( verbosity === undefined || _.numberDefined( verbosity ) || _.logger.like( verbosity ) );

  if( _.logger.like( verbosity ) )
  return verbosity;

  verbosity = verbosity || 1;

  if( result === null )
  {
    result = new _.Logger({ output : _global_.logger, verbosity });
  }
  else if( _.boolIs( result ) )
  {
    if( result )
    result = new _.Logger({ output : _global_.logger, verbosity : verbosity });
    else if( verbosity > 0 )
    result = new _.Logger({ output : _global_.logger, verbosity });
    else
    result = false;
  }
  else if( _.numberIs( result ) )
  {
    result += verbosity;
    if( result > 0 )
    result = new _.Logger({ output : _global_.logger, verbosity : result });
    else
    result = false;
  }
  else if( _.logger.is( result ) )
  {
    if( verbosity !== 0 )
    result = new _.Logger({ output : result, verbosity : verbosity });
  }
  else _.assert( 0 );

  return result;
}

//

function verbosityFrom( src )
{
  let result = src;

  _.assert( _.boolIs( result ) || _.numberIs( result ) );
  _.assert( arguments.length === 1 );

  if( _.boolIs( result ) )
  {
    result = 1;
  }

  return result;
}

//

function verbosityRelative( src, delta )
{
  let result = src;

  _.assert( _.boolIs( result ) || _.numberIs( result ) );
  _.assert( delta === undefined || _.numberDefined( delta ) );

  delta = delta || 0;

  if( _.boolIs( result ) )
  {
    if( result )
    result = 1 + delta;
    else
    result = delta;
  }
  else if( _.numberIs( result ) )
  {
    result += delta;
  }

  return result;
}

// --
// tools extension
// --

let ToolsExtension =
{
  consoleIs,
  loggerIs : is,
  loggerLike : like,
}

//

Object.assign( _, ToolsExtension );

// --
// logger extension
// --

let LoggerExtension =
{
  is,
  like,
  fromStrictly, /* qqq : cover */
  maybe, /* qqq : cover */
  relativeMaybe, /* qqq : cover */
  absoluteMaybe, /* qqq : cover */
  verbosityFrom, /* qqq : cover */
  verbosityRelative, /* qqq : cover */
}

//

Object.assign( _.logger, LoggerExtension );

})();
