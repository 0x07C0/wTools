( function _iErr_s_() {

'use strict';

/*

!!! implement error's collectors
!!! marry with procedures

*/

// let Object.prototype.toString = Object.prototype.toString;
// let _ObjectHasOwnProperty = Object.hasOwnProperty;

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

_.process = _.process || Object.create( null );
_.err = _.err || Object.create( null );

// --
// stub
// --

function diagnosticLocation( o )
{

  if( _.numberIs( o ) )
  o = { level : o }
  else if( _.strIs( o ) )
  o = { stack : o, level : 0 }
  else if( _.errIs( o ) )
  o = { error : o, level : 0 }
  else if( o === undefined )
  o = { stack : _.diagnosticStack([ 0, Infinity ]) };

  /* */

  if( diagnosticLocation.defaults )
  for( let e in o )
  {
    if( diagnosticLocation.defaults[ e ] === undefined )
    throw Error( 'Unknown option ' + e );
  }

  if( diagnosticLocation.defaults )
  for( let e in diagnosticLocation.defaults )
  {
    if( o[ e ] === undefined )
    o[ e ] = diagnosticLocation.defaults[ e ];
  }

  if( !( arguments.length === 0 || arguments.length === 1 ) )
  throw Error( 'Expects single argument or none' );

  if( !( _.objectIs( o ) ) )
  throw Error( 'Expects options map' );

  if( !o.level )
  o.level = 0;

  /* */

  if( !o.location )
  o.location = Object.create( null );

  /* */

  if( o.error )
  {
    let location2 = o.error.location || Object.create( null );

    o.location.path = _.longLeftDefined([ location2.path, o.location.path, o.error.filename, o.error.fileName ]).element;
    o.location.line = _.longLeftDefined([ location2.line, o.location.line, o.error.line, o.error.linenumber, o.error.lineNumber, o.error.lineNo, o.error.lineno ]).element;
    o.location.col = _.longLeftDefined([ location2.col, o.location.col, o.error.col, o.error.colnumber, o.error.colNumber, o.error.colNo, o.error.colno ]).element;

  }

  /* */

  if( !o.stack )
  {
    if( o.error )
    {
      o.stack = _.diagnosticStack( o.error, undefined );
    }
    else
    {
      o.stack = _.diagnosticStack();
      o.level += 1;
    }
  }

  let stack = o.stack;
  if( _.strIs( stack ) )
  stack = stack.split( '\n' );
  let stackCall = stack[ o.level ];

  return _.diagnosticLocationFromCall({ stackCall : stackCall, location : o.location });

  // let stack = o.stack;
  // if( !o.location.routine || !_.numberIs( o.location.detailing ) )
  // routineFromStack();
  // let hadPath = !!o.location.path;
  // if( !o.location.path )
  // o.location.path = pathFromStack();
  //
  // if( !_.strIs( o.location.path ) )
  // return end();
  //
  // if( !_.numberIs( o.location.line ) )
  // o.location.path = lineColFromPath( o.location.path );
  //
  // if( !_.numberIs( o.location.line ) && hadPath )
  // {
  //   debugger;
  //   let path = pathFromStack();
  //   if( path )
  //   lineColFromPath( path );
  // }
  //
  // return end();

  /* */

  // function end()
  // {
  //
  //   let path = o.location.path;
  //
  //   /* full */
  //
  //   o.location.full = path || '';
  //   if( o.location.line !== undefined )
  //   o.location.full += ':' + o.location.line;
  //
  //   /* name long */
  //
  //   if( o.location.full )
  //   {
  //     o.location.fullWithRoutine = o.location.routine + ' @ ' + o.location.full;
  //     // o.location.fullWithRoutine = o.location.fullWithRoutine.trim();
  //   }
  //
  //   /* name */
  //
  //   if( path )
  //   {
  //     let name = path;
  //     _.assert( name.lastIndexOf );
  //     let i = name.lastIndexOf( '/' );
  //     if( i !== -1 )
  //     name = name.substr( i+1 );
  //     o.location.name = name;
  //   }
  //
  //   /* name long */
  //
  //   if( path )
  //   {
  //     let nameLong = o.location.name;
  //     if( o.location.line !== undefined )
  //     {
  //       nameLong += ':' + o.location.line;
  //       if( o.location.col !== undefined )
  //       nameLong += ':' + o.location.col;
  //     }
  //     o.location.nameLong = nameLong;
  //   }
  //
  //   return o.location;
  // }
  //
  // /* */
  //
  // function routineFromStack()
  // {
  //   let path;
  //
  //   if( o.location.routine )
  //   {
  //     path = o.location.routine;
  //   }
  //   else
  //   {
  //
  //     if( !stack )
  //     return;
  //
  //     if( _.strIs( stack ) )
  //     stack = stack.split( '\n' );
  //
  //     path = stack[ o.level ];
  //
  //     if( !_.strIs( path ) )
  //     return '(-routine anonymous-)';
  //
  //     let t = /^\s*(at\s+)?([\w\.]+)\s*.+/;
  //     let executed = t.exec( path );
  //     if( executed )
  //     path = executed[ 2 ] || '';
  //
  //   }
  //
  //   if( _.strEnds( path, '.' ) )
  //   path += '?';
  //
  //   o.location.routine = path;
  //   o.location.detailing = 0;
  //   if( o.location.detailing === 0 )
  //   if( _.strBegins( path , '__' ) || path.indexOf( '.__' ) !== -1 )
  //   o.location.detailing = 2;
  //   if( o.location.detailing === 0 )
  //   if( _.strBegins( path , '_' ) || path.indexOf( '._' ) !== -1 )
  //   o.location.detailing = 1;
  //
  //   return path;
  // }
  //
  // /* */
  //
  // function pathFromStack()
  // {
  //   let path;
  //
  //   if( !stack )
  //   return;
  //
  //   if( _.strIs( stack ) )
  //   stack = stack.split( '\n' );
  //
  //   path = stack[ o.level ];
  //
  //   if( !_.strIs( path ) )
  //   return;
  //
  //   path = path.replace( /^\s+/, '' );
  //   path = path.replace( /^\w+@/, '' );
  //   path = path.replace( /^at/, '' );
  //   path = path.replace( /^\s+/, '' );
  //   path = path.replace( /\s+$/, '' );
  //
  //   let regexp = /^.*\((.*)\)$/;
  //   var parsed = regexp.exec( path );
  //   if( parsed )
  //   path = parsed[ 1 ];
  //
  //   return path;
  // }
  //
  // /* line / col number from path */
  //
  // function lineColFromPath( path )
  // {
  //
  //   let lineNumber, colNumber;
  //   let postfix = /(.+?):(\d+)(?::(\d+))?[^:/]*$/;
  //   let parsed = postfix.exec( path );
  //
  //   if( parsed )
  //   {
  //     path = parsed[ 1 ];
  //     lineNumber = parsed[ 2 ];
  //     colNumber = parsed[ 3 ];
  //   }
  //
  //   lineNumber = parseInt( lineNumber );
  //   colNumber = parseInt( colNumber );
  //
  //   if( isNaN( o.location.line ) && !isNaN( lineNumber ) )
  //   o.location.line = lineNumber;
  //
  //   if( isNaN( o.location.col ) && !isNaN( colNumber ) )
  //   o.location.col = colNumber;
  //
  //   return path;
  // }

}

diagnosticLocation.defaults =
{
  level : 0,
  stack : null,
  error : null,
  location : null,
}

//

function diagnosticLocationFromCall( o )
{

  if( _.strIs( o ) )
  o = { stackCall : o }

  /* */

  if( diagnosticLocationFromCall.defaults )
  for( let e in o )
  {
    if( diagnosticLocationFromCall.defaults[ e ] === undefined )
    throw Error( 'Unknown option ' + e );
  }

  if( diagnosticLocationFromCall.defaults )
  for( let e in diagnosticLocationFromCall.defaults )
  {
    if( o[ e ] === undefined )
    o[ e ] = diagnosticLocationFromCall.defaults[ e ];
  }

  if( !( arguments.length === 1 ) )
  throw Error( 'Expects single argument' );

  if( !( _.objectIs( o ) ) )
  throw Error( 'Expects options map' );

  if( !( _.strIs( o.stackCall ) ) )
  throw Error( `Expects string {- stackCall -}, but fot ${_.strType( stackCall )}` );

  /* */

  if( !o.location )
  o.location = Object.create( null );

  if( !o.location.original )
  o.location.original = o.stackCall;

  if( !o.location.routine || !_.numberIs( o.location.detailing ) )
  routineFromStack();
  let hadPath = !!o.location.path;
  if( !o.location.path )
  o.location.path = pathFromStack();

  if( o.location.isInternal === null || o.location.isInternal === undefined )
  {
    o.location.isInternal = null;
    if( o.location.path )
    o.location.isInternal = _.strBegins( o.location.path, 'internal/' );
  }

  if( !_.strIs( o.location.path ) )
  return end();

  if( !_.numberIs( o.location.line ) )
  o.location.path = lineColFromPath( o.location.path );

  if( !_.numberIs( o.location.line ) && hadPath )
  {
    debugger;
    let path = pathFromStack();
    if( path )
    lineColFromPath( path );
  }

  return end();

  /* */

  function end()
  {

    let path = o.location.path;

    /* full */

    o.location.full = path || '';
    if( o.location.line !== undefined )
    o.location.full += ':' + o.location.line;

    /* name long */

    if( o.location.full )
    {
      o.location.fullWithRoutine = o.location.routine + ' @ ' + o.location.full;
    }

    /* name */

    if( path )
    {
      let name = path;
      _.assert( name.lastIndexOf );
      let i = name.lastIndexOf( '/' );
      if( i !== -1 )
      name = name.substr( i+1 );
      o.location.name = name;
    }

    /* name long */

    if( path )
    {
      let nameLong = o.location.name;
      if( o.location.line !== undefined )
      {
        nameLong += ':' + o.location.line;
        if( o.location.col !== undefined )
        nameLong += ':' + o.location.col;
      }
      o.location.nameLong = nameLong;
    }

    return o.location;
  }

  /* */

  function routineFromStack()
  {
    let routine;

    if( o.location.routine )
    {
      routine = o.location.routine;
    }
    else
    {

      routine = o.stackCall;

      if( !_.strIs( routine ) )
      return '{- routine anonymous -}';

      let t = /^\s*(at\s+)?([\w\.]+)\s*.+/;
      let executed = t.exec( routine );
      if( executed )
      routine = executed[ 2 ] || '';

    }

    if( _.strEnds( routine, '.' ) )
    routine += '?';

    o.location.routine = routine;
    o.location.detailing = 0;
    if( o.location.detailing === 0 )
    if( _.strBegins( routine , '__' ) || routine.indexOf( '.__' ) !== -1 )
    o.location.detailing = 2;
    if( o.location.detailing === 0 )
    if( _.strBegins( routine , '_' ) || routine.indexOf( '._' ) !== -1 )
    o.location.detailing = 1;

    return routine;
  }

  /* */

  function pathFromStack()
  {
    let path = o.stackCall;

    if( !_.strIs( path ) )
    return;

    path = path.replace( /^\s+/, '' );
    path = path.replace( /^\w+@/, '' );
    path = path.replace( /^at/, '' );
    path = path.replace( /^\s+/, '' );
    path = path.replace( /\s+$/, '' );

    let regexp = /^.*\((.*)\)$/;
    var parsed = regexp.exec( path );
    if( parsed )
    path = parsed[ 1 ];

    return path;
  }

  /* line / col number from path */

  function lineColFromPath( path )
  {

    let lineNumber, colNumber;
    let postfix = /(.+?):(\d+)(?::(\d+))?[^:/]*$/;
    let parsed = postfix.exec( path );

    if( parsed )
    {
      path = parsed[ 1 ];
      lineNumber = parsed[ 2 ];
      colNumber = parsed[ 3 ];
    }

    lineNumber = parseInt( lineNumber );
    colNumber = parseInt( colNumber );

    if( isNaN( o.location.line ) && !isNaN( lineNumber ) )
    o.location.line = lineNumber;

    if( isNaN( o.location.col ) && !isNaN( colNumber ) )
    o.location.col = colNumber;

    return path;
  }

}

diagnosticLocationFromCall.defaults =
{
  stackCall : null,
  location : null,
}

//

/**
 * Return stack trace as string.
 * @example
 * let stack;
 * function function1()
 * {
 *   function2();
 * }
 *
 * function function2()
 * {
 *   function3();
 * }
 *
 * function function3()
 * {
 *   stack = _.diagnosticStack();
 * }
 *
 * function1();
 * console.log( stack );
 * // log
 * //"    at function3 (<anonymous>:10:17)
 * // at function2 (<anonymous>:6:2)
 * // at function1 (<anonymous>:2:2)
 * // at <anonymous>:1:1"
 *
 * @returns {String} Return stack trace from call point.
 * @function diagnosticStack
 * @memberof wTools
 */

function diagnosticStack( stack, range )
{

  if( arguments.length === 1 )
  {
    if( !_.errIs( stack ) )
    if( !_.strIs( stack ) )
    {
      range = arguments[ 0 ];
      stack = undefined;
    }
  }

  if( stack === undefined || stack === null )
  {
    stack = new Error();
    if( range === undefined )
    {
      range = [ 1, Infinity ];
    }
    else
    {
      range[ 0 ] += 1;
      if( range[ 1 ] >= 0 )
      range[ 1 ] += 1;
    }
  }

  if( range === undefined )
  range = [ 0, Infinity ];

  if( arguments.length !== 0 && arguments.length !== 1 && arguments.length !== 2 )
  {
    debugger;
    throw Error( 'diagnosticStack : expects one or two or none arguments' );
  }

  if( !_.rangeIs( range ) )
  {
    debugger;
    throw Error( 'diagnosticStack : expects range but, got ' + _.strType( range ) );
  }

  let first = range[ 0 ];
  let last = range[ 1 ];

  if( !_.numberIs( first ) )
  {
    debugger;
    throw Error( 'diagnosticStack : expects number range[ 0 ], but got ' + _.strType( first ) );
  }

  if( !_.numberIs( last ) )
  {
    debugger;
    throw Error( 'diagnosticStack : expects number range[ 0 ], but got ' + _.strType( last ) );
  }

  let errIs = 0;
  if( _.errIs( stack ) )
  {
    stack = _.errOriginalStack( stack );
    errIs = 1;
  }

  if( !stack )
  return '';

  if( !_.arrayIs( stack ) && !_.strIs( stack ) )
  return;

  if( !_.arrayIs( stack ) && !_.strIs( stack ) )
  {
    debugger;
    throw Error( 'diagnosticStack expects array or string' );
  }

  if( !_.arrayIs( stack ) )
  stack = stack.split( '\n' );

  /* remove redundant lines */

  while( stack.length )
  {
    let splice = 0;
    splice |= ( _.strHas( stack[ 0 ], /(^| )at / ) === false && stack[ 0 ].indexOf( '@' ) === -1 );
    splice |= stack[ 0 ].indexOf( '(vm.js:' ) !== -1;
    splice |= stack[ 0 ].indexOf( '(module.js:' ) !== -1;
    splice |= stack[ 0 ].indexOf( '(internal/module.js:' ) !== -1;
    if( splice )
    stack.splice( 0, 1 );
    else break;
  }

  if( stack[ 0 ] )
  if( stack[ 0 ].indexOf( 'at ' ) === -1 && stack[ 0 ].indexOf( '@' ) === -1 )
  {
    console.error( 'diagnosticStack : failed to parse stack' );
    debugger;
  }

  stack = stack.map( ( line ) => line.trim() );
  stack = stack.filter( ( line ) => line );

  /* */

  first = first === undefined ? 0 : first;
  last = last === undefined ? stack.length : last;

  if( _.numberIs( first ) )
  if( first < 0 )
  first = stack.length + first;

  if( _.numberIs( last ) )
  if( last < 0 )
  last = stack.length + last + 1;

  /* */

  if( first !== 0 || last !== stack.length )
  {
    stack = stack.slice( first || 0, last );
  }

  /* */

  stack = String( stack.join( '\n' ) );

  return stack;
}

//

function diagnosticStackRemoveLeft( stack, include, exclude )
{
  if( arguments.length !== 3 )
  throw Error( 'Expects two arguments' );
  if( !_.regexpIs( include ) && include !== null )
  throw Error( 'Expects regexp either null as the second argument' );
  if( !_.regexpIs( exclude ) && exclude !== null )
  throw Error( 'Expects regexp either null as the third argument' );

  if( !_.strIs( stack ) )
  return stack;

  stack = stack.split( '\n' );

  for( let s = stack.length-1 ; s >= 0 ; s-- )
  {
    let line = stack[ s ];
    if( include && include.test( line ) )
    {
      stack.splice( s, 1 );
      continue;
    }
    if( exclude && exclude.test( line ) )
    {
      stack.splice( s, 1 );
      continue;
    }
  }

  return stack.join( '\n' );
}

//

function diagnosticStackCondense( stack )
{

  if( arguments.length !== 1 )
  throw Error( 'Expects single arguments' );

  if( !_.strIs( stack ) )
  {
    debugger;
    throw Error( 'Expects string' );
  }

  stack = stack.split( '\n' );

  for( let s = stack.length-1 ; s >= 0 ; s-- )
  {
    let line = stack[ s ];
    if( s > 0 )
    if( /(\W|^)__\w+/.test( line ) )
    {
      stack.splice( s, 1 );
      continue;
    }
    if( _.strHas( line, '.test.' ) )
    line += ' *';
    stack[ s ] = line;
  }

  return stack.join( '\n' );
}

//

function diagnosticStackFilter( stack, onEach )
{
  let result = [];

  if( _.routineIs( stack ) )
  {
    onEach = stack;
    stack = undefined;
  }

  if( !_.strIs( stack ) )
  stack = _.diagnosticStack( stack );

  _.assert( _.strIs( stack ) );
  _.assert( _.routineIs( onEach ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  stack = stack.split( '\n' );

  stack.forEach( ( stackCall, k ) =>
  {
    let location = _.diagnosticLocationFromCall( stackCall );
    let r = onEach( location, k );
    if( r === undefined )
    return;
    if( _.strIs( r ) )
    {
      result.push( r );
      return;
    }
    _.assert( _.objectIs( r ) );
    _.assert( _.strIs( r.original ) );
    result.push( r.original );
  });

  return result.join( '\n' );
}

//

// function diagnosticStackFirstLeft( stack )
// {
//   if( !_.strIs( stack ) )
//   stack = _.diagnosticStack( stack );
//
//   _.assert( _.strIs( stack ) );
//   _.assert( arguments.length === 1 );
//
//   debugger; xxx
//
// }

//

function diagnosticCode()
{
  return undefined;
}

// --
// error
// --

function errIs( src )
{
  return src instanceof Error || Object.prototype.toString.call( src ) === '[object Error]';
}

//

function errIsStandard( src )
{
  if( !_.errIs( src ) )
  return false;
  return src.originalMessage !== undefined;
}

//

function errIsAttended( src )
{
  if( !_.errIs( src ) )
  return false;
  return !!src.attended;
}

//

function errIsLogged( src )
{
  if( _.errIs( src ) === false )
  return false;
  return !!src.logged;
}

//

function errIsBrief( src )
{
  if( !_.errIs( src ) )
  return false;
  return !!src.brief;
}

//

function errIsProcess( src )
{
  if( !_.errIs( src ) )
  return false;
  return !!src.isProcess;
}

// //
//
// function errIsAttentionRequested( src )
// {
//   if( _.errIs( src ) === false )
//   return false;
//   return src.attentionRequested;
// }
//
// //
//
// function errAttentionRequest( err )
// {
//
//   if( arguments.length !== 1 )
//   throw Error( 'errAttentionRequest : Expects one argument' );
//   if( !_.errIs( err ) )
//   throw Error( 'errAttentionRequest : Expects error as the first argument' );
//
//   Object.defineProperty( err, 'attended',
//   {
//     enumerable : false,
//     configurable : true,
//     writable : true,
//     value : 0,
//   });
//
//   Object.defineProperty( err, 'attentionRequested',
//   {
//     enumerable : false,
//     configurable : true,
//     writable : true,
//     value : 1,
//   });
//
//   return err;
// }

//

function errOriginalMessage( err )
{

  if( arguments.length !== 1 )
  throw Error( 'errOriginalMessage : Expects single argument' );

  if( _.strIs( err ) )
  return err;

  if( !err )
  return;

  if( err.originalMessage )
  return err.originalMessage;

  let message = err.message;

  if( !message && message !== '' )
  message = err.msg;
  if( !message && message !== '' )
  message = err.name;

  // fallBackMessage = fallBackMessage || err.constructor.name;

  if( _.mapFields )
  {
    let fields = _.mapFields( err );
    if( Object.keys( fields ).length )
    message += '\n' + _.toStr( fields, { wrap : 0, multiline : 1, levels : 2 } );
  }

  return message;
}

//

function errOriginalStack( err )
{

  if( arguments.length !== 1 )
  throw Error( 'errOriginalStack : Expects single argument' );

  if( !_.errIs( err ) )
  throw Error( 'errOriginalStack : Expects error' );

  if( err.throwenCallsStack )
  return err.throwenCallsStack;

  if( err.callsStack )
  return err.callsStack;

  if( err[ stackSymbol ] )
  return err[ stackSymbol ];

  // if( err.stackCondensed )
  // return err.stackCondensed;

  return _.diagnosticStack( err.stack );
}

//

/**
 * Creates Error object based on passed options.
 * Result error contains in message detailed stack trace and error description.
 * @param {Object} o Options for creating error.
 * @param {String[]|Error[]} o.args array with messages or errors objects, from which will be created Error obj.
 * @param {number} [o.level] using for specifying in error message on which level of stack trace was caught error.
 * @returns {Error} Result Error. If in `o.args` passed Error object, result will be reference to it.
 * @private
 * @throws {Error} Expects single argument if pass les or more than one argument
 * @throws {Error} o.args should be array like, if o.args is not array.
 * @function _err
 * @memberof wTools
 */

let _errorCounter = 0;
let _errorMaking = false;
function _err( o )
{
  let resultError;

  if( arguments.length !== 1 )
  throw Error( '_err : Expects single argument' );

  if( !_.longIs( o.args ) )
  throw Error( '_err : o.args should be array like' );

  for( let e in o )
  {
    if( _err.defaults[ e ] === undefined )
    throw Error( 'Unknown option ' + e );
  }

  for( let e in _err.defaults )
  {
    if( o[ e ] === undefined )
    o[ e ] = _err.defaults[ e ];
  }

  if( _errorMaking )
  {
    debugger;
    throw Error( '_err : recursive dead lock because of error inside of routine _err!' );
  }
  _errorMaking = true;

  if( o.level === undefined || o.level === null )
  o.level = null;

  if( o.args[ 0 ] === 'not implemented' || o.args[ 0 ] === 'not tested' || o.args[ 0 ] === 'unexpected' )
  if( _.debuggerEnabled )
  debugger;

  /* let */

  let sections;
  let id = null;
  let originalMessage = '';
  let fallBackMessage = '';
  let throwsStack = '';
  let sourceCode = null;
  let errors = [];
  let attended = false;
  let logged = false;
  let stackCondensed = '';
  let message = null;

  /* algorithm */

  try
  {

    argumentsPreprocess();
    locationForm();
    stackAndErrorForm();
    attributesForm();
    catchesForm();
    sourceCodeForm();
    originalMessageForm();

    sectionsForm();
    messageForm();
    fieldsForm();

  }
  catch( err2 )
  {
    debugger;
    _errorMaking = false;
    logger.log( err2.message );
    logger.log( err2.stack );
  }
  _errorMaking = false;

  return resultError;

  /* */

  function strIndentation( str, indentation )
  {
    if( _.strIndentation )
    return indentation + _.strIndentation( str, indentation );
    else
    return str;
  }

  /* */

  function argumentsPreprocess()
  {

    for( let a = 0 ; a < o.args.length ; a++ )
    {
      let arg = o.args[ a ];

      if( !_.errIs( arg ) && _.routineIs( arg ) )
      {
        if( arg.length === 0 )
        arg = o.args[ a ] = arg();
        if( _.unrollIs( arg ) )
        {
          o.args = _.longBut( o.args, [ a, a+1 ], arg );
          a -= 1;
          continue;
        }
      }

      if( _.errIs( arg ) )
      {

        if( !resultError )
        {
          resultError = arg;
          throwsStack = arg.throwsStack || '';
          sourceCode = arg.sourceCode || null;
          attended = arg.attended || false;
          logged = arg.logged || false;
        }

        if( arg.constructor )
        fallBackMessage = fallBackMessage || arg.constructor.name;
        errors.push( arg );

        // o.location = _.diagnosticLocation({ error : arg, location : o.location });
        o.args[ a ] = _.errOriginalMessage( arg )

      }

    }

  }

  /* */

  function locationForm()
  {

    if( !resultError )
    for( let a = 0 ; a < o.args.length ; a++ )
    {
      let arg = o.args[ a ];
      if( !_.primitiveIs( arg ) && _.objectLike( arg ) )
      o.throwenLocation = _.diagnosticLocation({ error : arg, location : o.throwenLocation });
    }

    o.throwenLocation = o.throwenLocation || Object.create( null );
    o.caughtLocation = o.caughtLocation || Object.create( null );

  }

  /* */

  function stackAndErrorForm()
  {

    if( resultError )
    {

      if( !o.throwenCallsStack )
      o.throwenCallsStack = _.errOriginalStack( resultError );
      if( !o.caughtCallsStack )
      {
        o.caughtCallsStack = _.diagnosticStack( o.caughtCallsStack, [ ( o.level || 0 ) + 1, Infinity ] );
      }
      if( !o.throwenCallsStack && o.caughtCallsStack )
      {
        o.throwenCallsStack = o.caughtCallsStack;
      }
      if( !o.throwenCallsStack )
      {
        o.throwenCallsStack = _.diagnosticStack( resultError, [ ( o.level || 0 ) + 1, Infinity ] );
      }
      o.level = 0;

    }
    else
    {

      resultError = new Error( originalMessage + '\n' );
      if( o.throwenCallsStack )
      {
        resultError.stack = o.throwenCallsStack;
        o.caughtCallsStack = _.diagnosticStack( o.caughtCallsStack, [ o.level + 1, Infinity ] );
        o.level = 0;
      }
      else
      {
        if( o.caughtCallsStack )
        {
          o.throwenCallsStack = resultError.stack = o.caughtCallsStack;
        }
        else
        {
          if( o.level === undefined || o.level === null )
          o.level = 1;
          o.level += 1;
          o.throwenCallsStack = resultError.stack = _.diagnosticStack( resultError.stack, [ o.level, Infinity ] );
        }
        o.level = 0;
        if( !o.caughtCallsStack )
        o.caughtCallsStack = o.throwenCallsStack;
      }

    }

    _.assert( o.level === 0 );

    if( ( o.stackRemovingBeginIncluding || o.stackRemovingBeginExcluding ) && o.throwenCallsStack )
    o.throwenCallsStack = _.diagnosticStackRemoveLeft( o.throwenCallsStack, o.stackRemovingBeginIncluding || null, o.stackRemovingBeginExcluding || null );

    if( !o.throwenCallsStack )
    o.throwenCallsStack = resultError.stack = o.fallBackStack;

    stackCondensed = o.throwenCallsStack;

    // if( o.asyncCallsStack === null || o.asyncCallsStack === undefined )
    // o.asyncCallsStack = resultError.asyncCallsStack || null;
    _.assert( resultError.asyncCallsStack === undefined || resultError.asyncCallsStack === null || _.arrayIs( resultError.asyncCallsStack ) );
    if( resultError.asyncCallsStack && resultError.asyncCallsStack.length )
    {
      o.asyncCallsStack = o.asyncCallsStack || [];
      _.arrayAppendArray( o.asyncCallsStack, resultError.asyncCallsStack );
    }

    if( o.asyncCallsStack === null || o.asyncCallsStack === undefined )
    if( _.procedure && _.procedure.activeProcedure )
    o.asyncCallsStack = [ _.procedure.activeProcedure.stack() ];

    _.assert( o.asyncCallsStack === null || _.arrayIs( o.asyncCallsStack ) );
    if( o.asyncCallsStack && o.asyncCallsStack.length )
    {
      stackCondensed += '\n\n' + o.asyncCallsStack.join( '\n\n' );
    }

    _.assert( _.strIs( stackCondensed ) );
    if( o.stackCondensing )
    stackCondensed = _.diagnosticStackCondense( stackCondensed );

  }

  /* */

  function attributesForm()
  {

    o.caughtLocation = _.diagnosticLocation
    ({
      stack : o.caughtCallsStack,
      location : o.caughtLocation,
    });

    o.throwenLocation = _.diagnosticLocation
    ({
      error : resultError,
      stack : o.throwenCallsStack,
      location : o.throwenLocation,
    });

    if( o.brief === null || o.brief === undefined )
    o.brief = resultError.brief;
    o.brief = !!o.brief;

    if( o.isProcess === null || o.isProcess === undefined )
    o.isProcess = resultError.isProcess;
    o.isProcess = !!o.isProcess;

    if( o.debugging === null || o.debugging === undefined )
    o.debugging = resultError.debugging;
    o.debugging = !!o.debugging;

    sections = resultError.section || Object.create( null );
    if( o.sections )
    _.mapExtend( sections, o.sections );

    id = resultError.id;
    if( !id )
    {
      _errorCounter += 1;
      id = _errorCounter;
    }

  }

  /* */

  function catchesForm()
  {

    if( o.throws )
    {
      _.assert( _.arrayIs( o.throws ) );
      o.throws.forEach( ( c ) =>
      {
        c = _.diagnosticLocation( c ).fullWithRoutine;
        if( throwsStack )
        throwsStack = `${throwsStack}\nthrown at ${c}`;
        else
        throwsStack = `thrown at ${c}`;
      });
    }

    _.assert( _.numberIs( o.caughtLocation.detailing ), resultError.id );
    if( !o.caughtLocation.detailing || o.caughtLocation.detailing === 1 )
    {
      if( throwsStack )
      throwsStack = `${throwsStack}\nthrown at ${o.caughtLocation.fullWithRoutine}`;
      else
      throwsStack = `thrown at ${o.caughtLocation.fullWithRoutine}`;
    }

  }

  /* */

  function sourceCodeForm()
  {

    if( o.usingSourceCode )
    if( resultError.sourceCode === undefined )
    {
      let c = _.diagnosticCode
      ({
        location : o.throwenLocation,
        sourceCode : o.sourceCode,
        asMap : 1,
      });
      if( c && c.code && c.code.length < 400 )
      {
        sourceCode = c;
      }
    }

  }

  /* */

  function originalMessageForm()
  {
    let multiline = false;
    let result = [];

    for( let a = 0 ; a < o.args.length ; a++ )
    {
      let arg = o.args[ a ];
      let str;

      if( arg && !_.primitiveIs( arg ) )
      {

        if( _.primitiveIs( arg ) )
        {
          str = String( arg );
        }
        else if( _.routineIs( arg.toStr ) )
        {
          str = arg.toStr();
        }
        else if( _.errIs( arg ) && _.strIs( arg.originalMessage ) )
        {
          str = arg.originalMessage;
        }
        else if( _.errIs( arg ) )
        {
          if( _.strIs( arg.originalMessage ) )
          str = arg.originalMessage;
          else if( _.strIs( arg.message ) )
          str = arg.message;
          else
          str = _.toStr( arg );
        }
        else
        {
          str = _.toStr( arg, { levels : 2 } );
        }
      }
      else if( arg === undefined )
      {
        str = '\n' + String( arg ) + '\n';
      }
      else
      {
        str = String( arg );
      }

      let currentIsMultiline = _.strHas( str, '\n' );
      if( currentIsMultiline )
      multiline = true;

      result[ a ] = str;

    }

    for( let a = 0 ; a < result.length ; a++ )
    {
      let str = result[ a ];

      if( !originalMessage.replace( /\s*/m, '' ) )
      {
        originalMessage = str;
      }
      else if( _.strEnds( originalMessage, '\n' ) || _.strBegins( str, '\n' ) )
      {
        originalMessage = originalMessage.replace( /\s+$/m, '' ) + '\n' + str;
      }
      else
      {
        originalMessage = originalMessage.replace( /\s+$/m, '' ) + ' ' + str.replace( /^\s+/m, '' );
      }

    }

    /*
      remove redundant eol from begin and end of message
    */

    originalMessage = originalMessage || fallBackMessage || 'UnknownError';
    originalMessage = originalMessage.replace( /^\x20*\n/m, '' );
    originalMessage = originalMessage.replace( /\x20*\n$/m, '' );

  }

  /* */

  function sectionsForm()
  {
    let result = '';

    sectionWrite( 'message', `Message of error#${id}`, originalMessage );
    sectionWrite( 'callsStack', o.stackCondensing ? 'Condensed calls stack' : 'Calls stack', stackCondensed );
    sectionWrite( 'throwsStack', `Throws stack`, throwsStack );

    if( o.isProcess && _.process && _.process.entryPointInfo )
    sectionWrite( 'process', `Process`, _.process.entryPointInfo() );

    if( sourceCode )
    sectionWrite( 'sourceCode', `Source code from ${sourceCode.path}`, sourceCode.code );

    for( let s in sections )
    {
      let section = sections[ s ];
      if( !_.strIs( section.head ) )
      {
        debugger;
        logger.error( `Each section of an error should have head, but head of section::${s} is ${_.strType(section.head)}` );
        delete sections[ s ];
      }
      if( !_.strIs( section.body ) )
      {
        debugger;
        logger.error( `Each section of an error should have body, but body of section::${s} is ${_.strType(section.body)}` );
        delete sections[ s ];
      }
    }

    return result;
  }

  /* */

  function sectionWrite( name, head, body )
  {
    let section = { head, body };
    sections[ name ] = section;
    return section;
  }

  /* */

  function messageForm()
  {
    let result = '';

    if( o.brief )
    {
      result += originalMessage;
    }
    else
    {

      for( let s in sections )
      {
        let section = sections[ s ];
        let head = section.head || '';
        let body = strIndentation( section.body, '    ' );
        if( !body.trim().length )
        continue;
        result += ` = ${head}\n${body}\n\n`;
      }

    }

    message = result;
    return result;
  }

  /* */

  function fieldsForm()
  {

    nonenumerable( 'message', message );
    nonenumerable( 'originalMessage', originalMessage );
    logging( 'stack', message );
    nonenumerable( 'callsStack', stackCondensed );
    nonenumerable( 'throwenCallsStack', o.throwenCallsStack );
    nonenumerable( 'throwsStack', throwsStack );
    nonenumerable( 'asyncCallsStack', o.asyncCallsStack );
    nonenumerable( 'catchCounter', resultError.catchCounter ? resultError.catchCounter+1 : 1 );
    nonenumerable( 'attended', attended );
    nonenumerable( 'logged', logged );
    nonenumerable( 'brief', o.brief );
    nonenumerable( 'isProcess', o.isProcess );

    if( o.throwenLocation.line !== undefined )
    nonenumerable( 'lineNumber', o.throwenLocation.line );
    if( resultError.throwenLocation === undefined )
    nonenumerable( 'throwenLocation', o.throwenLocation );
    nonenumerable( 'sourceCode', sourceCode || null );
    nonenumerable( 'debugging', o.debugging );
    nonenumerable( 'id', id );

    nonenumerable( 'toString', function() { return this.stack } );
    nonenumerable( 'sections', sections );

    if( o.debugging )
    debugger;

  }

  /* */

  function nonenumerable( fieldName, value )
  {
    // return rw( fieldName, value );
    try
    {
      Object.defineProperty( resultError, fieldName,
      {
        enumerable : false,
        configurable : true,
        writable : true,
        value : value,
      });
    }
    catch( err )
    {
      console.error( err );
      debugger;
      if( _.debuggerEnabled )
      debugger;
    }
  }

  /* */

  function rw( fieldName, value )
  {
    let symbol = Symbol.for( fieldName );
    try
    {
      resultError[ symbol ] = value;
      Object.defineProperty( resultError, fieldName,
      {
        enumerable : false,
        configurable : true,
        get : get,
        set : set,
      });
    }
    catch( err )
    {
      console.error( err );
      debugger;
      if( _.debuggerEnabled )
      debugger;
    }
    function get()
    {
      logger.log( `${fieldName} get ${this[ symbol ]}` );
      return this[ symbol ];
    }
    function set( src )
    {
      logger.log( `${fieldName} set` );
      this[ symbol ] = src;
      return src;
    }
  }

  /* */

  function logging( fieldName, value )
  {
    let symbol = Symbol.for( fieldName );
    try
    {
      // resultError[ symbol ] = value;
      nonenumerable( symbol, value );
      Object.defineProperty( resultError, fieldName,
      {
        enumerable : false,
        configurable : true,
        get : get,
        set : set,
      });
    }
    catch( err )
    {
      debugger;
      console.error( err );
      debugger;
      if( _.debuggerEnabled )
      debugger;
    }
    function get()
    {
      // if( this.id === 3 && this.throwsStack.split( '\n' ).length > 4 )
      // {
      //   logger.log( this.throwsStack ); debugger;
      // }
      _.errLogEnd( this );
      return this[ symbol ];
    }
    function set( src )
    {
      debugger;
      this[ symbol ] = src;
      return src;
    }
  }

}

_err.defaults =
{
  /* to make catch stack work properly level should be 1 by default */
  level : 1,
  stackRemovingBeginIncluding : null,
  stackRemovingBeginExcluding : null,
  usingSourceCode : 1,
  stackCondensing : 1,
  debugging : null,
  throwenLocation : null,
  caughtLocation : null,
  sourceCode : null,
  brief : null,
  isProcess : null,
  args : null,
  asyncCallsStack : null,
  throwenCallsStack : null,
  caughtCallsStack : null,
  fallBackStack : null,
  throws : null,
  sections : null,
}

//

/**
 * Creates error object, with message created from passed `msg` parameters and contains error trace.
 * If passed several strings (or mixed error and strings) as arguments, the result error message is created by
 concatenating them.
 *
 * @example
 * function divide( x, y )
 * {
 *   if( y == 0 )
 *     throw _.err( 'divide by zero' )
 *   return x / y;
 * }
 * divide( 3, 0 );
 *
 * // log
 * // Error:
 * // caught     at divide (<anonymous>:2:29)
 * // divide by zero
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:1418:13)
 * //   at wTools.err (file:///.../wTools/staging/Base.s:1449:10)
 * //   at divide (<anonymous>:2:29)
 * //   at <anonymous>:1:1
 *
 * @param {...String|Error} msg Accepts list of messeges/errors.
 * @returns {Error} Created Error. If passed existing error as one of parameters, routine modified it and return
 * reference.
 * @function err
 * @memberof wTools
 */

function err()
{
  return _._err
  ({
    args : arguments,
    level : 2,
  });
}

//

function errBrief()
{
  return _._err
  ({
    args : arguments,
    level : 2,
    brief : 1,
  });
}

//

function errUnbrief()
{
  return _._err
  ({
    args : arguments,
    level : 2,
    brief : 0,
  });
}

//

function errProcess()
{
  return _._err
  ({
    args : arguments,
    level : 2,
    isProcess : 1,
  });
}

//

function errUnprocess()
{
  return _._err
  ({
    args : arguments,
    level : 2,
    isProcess : 0,
  });
}

//

function errAttend( err )
{

  _.assert( arguments.length === 1 );

  if( !_.errIsStandard( err ) )
  err = _._err
  ({
    args : arguments,
    level : 2,
  });

  /* */

  try
  {

    // logger.log( `Attended error#${err.id}` );
    // if( err.id === 5 || err.id === 6 )
    // debugger;

    let value = Config.debug ? _.diagnosticStack([ 0, Infinity ]) : true;
    Object.defineProperty( err, 'attended',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : value,
    });

  }
  catch( err )
  {
    logger.warn( 'Cant assign attended property to error\n' + err.toString() );
  }

  /* */

  return err;
}

//

function errLogEnd( err )
{

  _.assert( arguments.length === 1 );

  if( !_.errIsStandard( err ) )
  err = _._err
  ({
    args : arguments,
    level : 2,
  });

  /* */

  try
  {

    let value = Config.debug ? _.diagnosticStack([ 0, Infinity ]) : true;
    Object.defineProperty( err, 'logged',
    {
      enumerable : false,
      configurable : true,
      writable : true,
      value : value,
    });

  }
  catch( err )
  {
    logger.warn( 'Cant assign logged property to error\n' + err.toString() );
  }

  _.errAttend( err );

  /* */

  return err;
}

//

function errRestack( err, level )
{

  if( err && err.debugging )
  debugger;

  if( !( arguments.length === 1 || arguments.length === 2 ) )
  throw Error( 'Expects single argument or none' );

  if( level === undefined )
  level = 1;

  if( !_.numberDefined( level ) )
  throw Error( 'Expects defined number' );

  let err2 = _._err
  ({
    args : [],
    level : level + 1,
  });

  return _.err( err2, err );
}

//

function errOnce( err )
{

  err = _._err
  ({
    args : arguments,
    level : 2,
  });

  if( err.logged )
  return undefined;

  _.errAttend( err );

  return err;
}

//

function _errLog( err )
{
  let c = _global.logger || _global.console;

  /* */

  if( err && err.debugging )
  debugger;

  debugger;
  if( _.routineIs( err.toString ) )
  {
    let str = err.toString();
    if( _.color && _.color.strFormat )
    str = _.color.strFormat( str, 'negative' );
    if( _.loggerIs( c ) )
    c.error( str )
    else
    c.error( str );
  }
  else
  {
    debugger;
    c.error( 'Error does not have toString' );
    c.error( err );
  }

  /* */

  _.errLogEnd( err );

  /* */

  return err;
}

//

/**
 * Creates error object, with message created from passed `msg` parameters and contains error trace.
 * If passed several strings (or mixed error and strings) as arguments, the result error message is created by
 concatenating them. Prints the created error.
 * If _global_.logger defined, routine will use it to print error, else uses console
 *
 * @see {@link wTools.err See err}
 *
 * @example
 * function divide( x, y )
 * {
 *   if( y == 0 )
 *    throw _.errLog( 'divide by zero' )
 *    return x / y;
 * }
 * divide( 3, 0 );
 *
 * // log
 * // Error:
 * // caught     at divide (<anonymous>:2:29)
 * // divide by zero
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:1418:13)
 * //   at wTools.errLog (file:///.../wTools/staging/Base.s:1462:13)
 * //   at divide (<anonymous>:2:29)
 * //   at <anonymous>:1:1
 *
 * @param {...String|Error} msg Accepts list of messeges/errors.
 * @returns {Error} Created Error. If passed existing error as one of parameters, routine modified it and return
 * @function errLog
 * @memberof wTools
 */

function errLog()
{

  let err = _._err
  ({
    args : arguments,
    level : 2,
  });

  return _._errLog( err );
}

//

function errLogOnce( err )
{

  err = _._err
  ({
    args : arguments,
    level : 2,
  });

  if( err.logged )
  return err;

  return _._errLog( err );
}

//

function error_functor( name, onMake )
{

  if( _.strIs( onMake ) || _.arrayIs( onMake ) )
  {
    let prepend = onMake;
    onMake = function onErrorMake()
    {
      debugger;
      let arg = _.arrayAppendArrays( [], [ prepend, arguments ] );
      return args;
    }
  }
  else if( !onMake )
  onMake = function onErrorMake()
  {
    return arguments;
  }

  let Error =
  {
    [ name ] : function()
    {
      if( !( this instanceof ErrorConstructor ) )
      {
        let err1 = new ErrorConstructor();
        let args1 = onMake.apply( err1, arguments );
        _.assert( _.arrayLike( args1 ) );
        let args2 = _.arrayAppendArrays( [], [ [ err1, ( arguments.length ? '\n' : '' ) ], args1 ] );
        let err2 = _._err({ args : args2, level : 3 });

        _.assert( err1 === err2 );
        _.assert( err2 instanceof _global.Error );
        _.assert( err2 instanceof ErrorConstructor );
        // _.assert( !!err2.stack );

        return err2;
      }
      else
      {
        _.assert( arguments.length === 0 );
        return this;
      }
    }
  }

  let ErrorConstructor = Error[ name ];

  _.assert( ErrorConstructor.name === name, 'Looks like your interpreter does not support dynamice naming of functions. Please use ES2015 or later interpreter.' );

  ErrorConstructor.prototype = Object.create( _global.Error.prototype );
  ErrorConstructor.prototype.constructor = ErrorConstructor;
  ErrorConstructor.constructor = ErrorConstructor;

  return ErrorConstructor;
}

// --
// try
// --

function tryCatch( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( routine ) )
  debugger;
  try
  {
    return routine();
  }
  catch( err )
  {
    debugger;
    throw _._err({ args : [ err ] });
  }
}

//

function tryCatchBrief( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( routine ) )
  debugger;
  try
  {
    return routine();
  }
  catch( err )
  {
    debugger;
    throw _._err({ args : [ err ], brief : 1 });
  }
}

//

function tryCatchDebug( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( routine ) )
  try
  {
    return routine();
  }
  catch( err )
  {
    throw _._err({ args : [ err ], debugging : 1 });
  }
}

// --
// surer
// --

function _sureDebugger( condition )
{
  if( _.debuggerEnabled )
  debugger;
}

//

function sure( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    _sureDebugger( condition );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      // args : _.longSlice( arguments,1 ),
      args : _.longSlice( arguments, 1 ),
      level : 2,
    });
  }

  return;

  function boolLike( src )
  {
    let type = Object.prototype.toString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureBriefly( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    _sureDebugger( condition );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
      brief : 1,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
      brief : 1,
    });
    else
    throw _err
    ({
      // args : _.longSlice( arguments,1 ),
      args : _.longSlice( arguments, 1 ),
      level : 2,
      brief : 1,
    });
  }

  return;

  function boolLike( src )
  {
    let type = Object.prototype.toString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureWithoutDebugger( condition )
{

  if( !condition || !boolLike( condition ) )
  {
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      // args : _.longSlice( arguments,1 ),
      args : _.longSlice( arguments, 1 ),
      level : 2,
    });
  }

  return;

  function boolLike( src )
  {
    let type = Object.prototype.toString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function sureInstanceOrClass( _constructor, _this )
{
  _.sure( arguments.length === 2, 'Expects exactly two arguments' );
  _.sure( _.isInstanceOrClass( _constructor, _this ) );
}

//

function sureOwnNoConstructor( ins )
{
  _.sure( _.objectLikeOrRoutine( ins ) );
  // let args = _.longSlice( arguments );
  let args = Array.prototype.slice.call( arguments );
  args[ 0 ] = _.isOwnNoConstructor( ins );
  _.sure.apply( _, args );
}

// --
// assert
// --

/**
 * Checks condition passed by argument( condition ). Works only in debug mode. Uses StackTrace level 2.
 *
 * @see {@link wTools.err err}
 *
 * If condition is true routine returns without exceptions, otherwise routine generates and throws exception. By default generates error with message 'Assertion fails'.
 * Also generates error using message(s) or existing error object(s) passed after first argument.
 *
 * @param {*} condition - condition to check.
 * @param {String|Error} [ msgs ] - error messages for generated exception.
 *
 * @example
 * let x = 1;
 * _.assert( _.strIs( x ), 'incorrect variable type->', typeof x, 'Expects string' );
 *
 * // log
 * // caught eval (<anonymous>:2:8)
 * // incorrect variable type-> number expects string
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:3707)
 * //   at assert (file://.../wTools/staging/Base.s:4041)
 * //   at add (<anonymous>:2)
 * //   at <anonymous>:1
 *
 * @example
 * function add( x, y )
 * {
 *   _.assert( arguments.length === 2, 'incorrect arguments count' );
 *   return x + y;
 * }
 * add();
 *
 * // log
 * // caught add (<anonymous>:3:14)
 * // incorrect arguments count
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:3707)
 * //   at assert (file://.../wTools/staging/Base.s:4035)
 * //   at add (<anonymous>:3:14)
 * //   at <anonymous>:6
 *
 * @example
 *   function divide ( x, y )
 *   {
 *      _.assert( y != 0, 'divide by zero' );
 *      return x / y;
 *   }
 *   divide( 3, 0 );
 *
 * // log
 * // caught     at divide (<anonymous>:2:29)
 * // divide by zero
 * // Error
 * //   at _err (file:///.../wTools/staging/Base.s:1418:13)
 * //   at wTools.errLog (file://.../wTools/staging/Base.s:1462:13)
 * //   at divide (<anonymous>:2:29)
 * //   at <anonymous>:1:1
 * @throws {Error} If passed condition( condition ) fails.
 * @function assert
 * @memberof wTools
 */

function _assertDebugger( condition, args )
{
  if( !_.debuggerEnabled )
  return;
  let err = _._err
  ({
    // args : _.longSlice( args, 1 ),
    args : Array.prototype.slice.call( args, 1 ),
    level : 3,
  });
  debugger;
}

//

function assert( condition )
{

  if( Config.debug === false )
  return true;

  if( !condition )
  {
    _assertDebugger( condition, arguments );
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      // args : _.longSlice( arguments, 1 ),
      args : Array.prototype.slice.call( arguments, 1 ),
      level : 2,
    });
  }

  return true;

  function boolLike( src )
  {
    let type = Object.prototype.toString.call( src );
    return type === '[object Boolean]' || type === '[object Number]';
  }

}

//

function assertWithoutBreakpoint( condition )
{

  /*return;*/

  if( Config.debug === false )
  return true;

  if( !condition || !_.boolLike( condition ) )
  {
    if( arguments.length === 1 )
    throw _err
    ({
      args : [ 'Assertion fails' ],
      level : 2,
    });
    else if( arguments.length === 2 )
    throw _err
    ({
      args : [ arguments[ 1 ] ],
      level : 2,
    });
    else
    throw _err
    ({
      // args : _.longSlice( arguments,1 ),
      args : Array.prototype.slice.call( arguments, 1 ),
      level : 2,
    });
  }

  return;
}

//

function assertNotTested( src )
{

  if( _.debuggerEnabled )
  debugger;
  _.assert( false,'not tested : ' + stack( 1 ) );

}

//

/**
 * If condition failed, routine prints warning messages passed after condition argument
 * @example
 * function checkAngles( a, b, c )
 * {
 *    _.assertWarn( (a + b + c) === 180, 'triangle with that angles does not exists' );
 * };
 * checkAngles( 120, 23, 130 );
 *
 * // log 'triangle with that angles does not exists'
 *
 * @param condition Condition to check.
 * @param messages messages to print.
 * @function assertWarn
 * @memberof wTools
 */

function assertWarn( condition )
{

  if( Config.debug )
  return;

  if( !condition || !_.boolLike( condition ) )
  {
    console.warn.apply( console,[].slice.call( arguments,1 ) );
  }

}

//

function assertInstanceOrClass( _constructor, _this )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.isInstanceOrClass( _constructor, _this ) );
}

//

function assertOwnNoConstructor( ins )
{
  _.assert( _.objectLikeOrRoutine( ins ) );
  // let args = _.longSlice( arguments );
  let args = Array.prototype.slice.call( arguments );
  args[ 0 ] = _.isOwnNoConstructor( ins );

  if( args.length === 1 )
  args.push( () => 'Entity should not own constructor, but own ' + _.toStrShort( ins ) );

  _.assert.apply( _, args );
}

// --
// process
// --

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
// fields
// --

let stackSymbol = Symbol.for( 'stack' );

/* Error.stackTraceLimit = 99; */

/**
 * @property {Object} error={}
 * @property {Boolean} debuggerEnabled=!!Config.debug
 * @name ErrFields
 * @memberof wTools
 */

let Fields =
{
  error : Object.create( null ),
  debuggerEnabled : !!Config.debug,
}

// --
// routines
// --

let ExtendProcess =
{

  entryPointStructure,
  entryPointInfo,

}

let Routines =
{

  // stack

  diagnosticLocation,
  diagnosticLocationFromCall,
  diagnosticStack, /* qqq : cover */
  diagnosticStackRemoveLeft,
  diagnosticStackCondense,
  diagnosticStackFilter, /* qqq : cover */
  diagnosticCode,

  // error

  errIs,
  errIsStandard,
  errIsAttended,
  errIsBrief,
  errIsProcess,
  errIsLogged,
  errOriginalMessage,
  errOriginalStack,

  _err,
  err,
  errBrief,
  errUnbrief,
  errProcess,
  errUnprocess,
  errAttend,
  errLogEnd,
  errRestack,
  errOnce,

  _errLog,
  errLog,
  errLogOnce,

  error_functor,

  // try

  tryCatch,
  tryCatchBrief,
  tryCatchDebug,

  // sure

  sure,
  sureBriefly,
  sureWithoutDebugger,

  // assert

  assert,
  assertWithoutBreakpoint,
  assertNotTested,
  assertWarn,

}

//

Object.assign( _.process, ExtendProcess );
Object.assign( _, Routines );
Object.assign( _, Fields );

/* xxx : put in _.err namespace */

Error.stackTraceLimit = Infinity;

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
