( function _Module_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;
const fileProvider = __.fileProvider;
const path = fileProvider.path;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..'  ), 'module' );
  // self.assetsOriginalPath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/module-' ) )
  path.tempClose( self.suiteTempPath );
}

// --
// test routines implementation
// --

function withIsIncluded( test )
{
  let context = this;
  let a = test.assetFor( false );
  let _ToolsPath_ = a.path.nativize( _.module.toolsPathGet() );
  let program1Path = a.program( program1 );
  let program2Path = a.program({ routine : program2, locals : { _ToolsPath_, program1Path } });

  /* */

  a.appStartNonThrowing({ execPath : program2Path })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'error' ), 0 );
    test.identical( _.strCount( op.output, 'program2.begin' ), 1 );
    test.identical( _.strCount( op.output, 'program1.begin' ), 1 );
    test.identical( _.strCount( op.output, 'program1.end' ), 1 );
    test.identical( _.strCount( op.output, 'program2.end' ), 1 );
    test.identical( _.strCount( op.output, /program2.begin(.|\n|\r)*program1.begin(.|\n|\r)*program1.end(.|\n|\r)*program2.end(.|\n|\r)*/mg ), 1 );
    return null;
  });

  /* */

  return a.ready;

  function program1()
  {
    console.log( 'program1.begin' );
    let _ = require( toolsPath );
    _global_.program2 = true;
    console.log( 'program1.end' );
  }

  function program2()
  {
    console.log( 'program2.begin' );
    let _ = require( _ToolsPath_ );
    _global_.program2 = true;
    _.module.predeclare
    ({
      name : 'program1',
      isIncluded : () => !!_global_.program1,
      entryPath : program1Path,
      basePath : '.',
    });
    _.include( 'program1' );
    _.include( 'program1' );
    console.log( 'program2.end' );
  }

}

//

function withoutIsIncluded( test )
{
  let context = this;
  let a = test.assetFor( false );
  let _ToolsPath_ = a.path.nativize( _.module.toolsPathGet() );
  let program1Path = a.program( program1 );
  let program2Path = a.program({ routine : program2, locals : { _ToolsPath_, program1Path } });

  /* */

  a.appStartNonThrowing({ execPath : program2Path })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'error' ), 0 );
    test.identical( _.strCount( op.output, 'program2.begin' ), 1 );
    test.identical( _.strCount( op.output, 'program1.begin' ), 1 );
    test.identical( _.strCount( op.output, 'program1.end' ), 1 );
    test.identical( _.strCount( op.output, 'program2.end' ), 1 );
    test.identical( _.strCount( op.output, /program2.begin(.|\n|\r)*program1.begin(.|\n|\r)*program1.end(.|\n|\r)*program2.end(.|\n|\r)*/mg ), 1 );
    return null;
  });

  /* */

  return a.ready;

  function program1()
  {
    console.log( 'program1.begin' );
    let _ = require( toolsPath );
    _global_.program2 = true;
    console.log( 'program1.end' );
  }

  function program2()
  {
    console.log( 'program2.begin' );
    let _ = require( _ToolsPath_ );
    _global_.program2 = true;
    _.module.predeclare
    ({
      name : 'program1',
      entryPath : program1Path,
      basePath : '.',
    });
    _.include( 'program1' );
    _.include( 'program1' );
    console.log( 'program2.end' );
  }

}

//

function moduleExportsUndefined( test )
{
  let context = this;
  let a = test.assetFor( false );
  let program1Path = a.program( program1 );
  let modulePath = a.path.join( program1Path, '../module.js' )

  a.fileProvider.fileWrite({ filePath : modulePath, data : `module.exports = undefined;` })

  /* */

  a.appStartNonThrowing({ execPath : program1Path })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'nhandled' ), 0 );
    test.identical( _.strCount( op.output, 'error' ), 0 );
    test.identical( _.strCount( op.output, 'program1.begin' ), 1 );
    test.identical( _.strCount( op.output, 'importedModule: undefined' ), 1 );
    test.identical( _.strCount( op.output, 'program1.end' ), 1 );
    return null;
  });

  /* */

  return a.ready;

  function program1()
  {
    console.log( 'program1.begin' );
    let _ = require( toolsPath );
    var importedModule = require( './module.js' );
    console.log( 'importedModule:', importedModule)
    console.log( 'program1.end' );
  }
}

moduleExportsUndefined.description  =
`
  Included module returns undefined
`

//

function resolve( test )
{
  let context = this;

  var exp = _.path.nativize( _.path.normalize( __dirname + '/../Layer1.s' ) );
  var got = _.module.resolve( 'wTools' );
  test.identical( got, exp );

}

resolve.description  =
`
  Routine _.module.resolve return path to include path of the specified module.
`

//

function toolsPathGetBasic( test )
{
  let context = this;

  /* */

  test.case = 'basic';
  var got = _.module.toolsPathGet();
  var exp = _.path.nativize( __.path.join( __dirname, '../../Tools.s' ) );
  test.identical( got, exp );
  console.log( `toolsPath : ${got}` );

  /* */

}

//

function toolsPathGetTester( test )
{
  let context = this;
  let a = test.assetFor( false );
  let programPath = a.program( program );

  console.log( 'programPath', programPath );

  var toolsPath1 = _.module.toolsPathGet();
  return a.forkNonThrowing({ execPath : programPath })
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var toolsPath2 = op.output.trim();
    var exp = __.path.join( __dirname, '../../Tools.s' );
    test.identical( toolsPath1, exp );
    test.identical( toolsPath2, exp );
    return op;
  });

  function program()
  {
    console.log( toolsPath );
  }

}

//

function includedModuleSourcePathValid( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  let start = __.process.starter
  ({
    outputCollecting : 1,
    outputPiping : 1,
    inputMirroring : 1,
    throwingExitCode : 0,
    mode : 'fork',
  });

  act({});

  /* */

  return ready;

  /* - */

  function act( env )
  {

    ready.then( () =>
    {
      test.case = `basic, ${__.entity.exportStringSolo( env )}`;

      let program0 = __.program.write
      ({
        routine : _program0,
        tempPath : a.abs( '.' ),
        moduleFile : _.module.fileWith( 0 ),
      });

      let program1 = __.program.write
      ({
        routine : _program1,
        tempPath : a.abs( '.' ),
        moduleFile : _.module.fileWith( 0 ),
      });
      console.log( _.strLinesNumber( program1.sourceCode ) );

      let program2 = __.program.write
      ({
        routine : _program2,
        tempPath : a.abs( '.' ),
        moduleFile : _.module.fileWith( 0 ),
      });

      let program3 = __.program.write
      ({
        routine : _program3,
        tempPath : a.abs( '.' ),
        moduleFile : _.module.fileWith( 0 ),
      });

      return start
      ({
        execPath : program0.programPath,
        currentPath : _.path.dir( program0.programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
  `
program0.begin
program1.begin
program1.begin : program0 : sourcePath : ${a.abs( '.' )}/_program0
program1.begin : program0 : requestedSourcePath : null
program1.begin : program0 : moduleFile : true
program1.begin : program0 : returned : 0
program1.begin : program0 : module : null
program1.begin : program1 : sourcePath : ${a.abs( '.' )}/_program1
program1.begin : program1 : requestedSourcePath : null
program1.begin : program1 : moduleFile : true
program1.begin : program1 : returned : [object Object]
program1.begin : program1 : module : null
program2.begin
program3
program3 : program2 : sourcePath : ${a.abs( '.' )}/_program2
program3 : program2 : requestedSourcePath : ./_program2
program3 : program2 : moduleFile : true
program3 : program2 : returned : [object Object]
program3 : program2 : module : null
program3 : program3 : sourcePath : ${a.abs( '.' )}/_program3
program3 : program3 : requestedSourcePath : ./_program3
program3 : program3 : moduleFile : true
program3 : program3 : returned : 3
program3 : program3 : module : null
program2.end
program1.after : program0 : sourcePath : ${a.abs( '.' )}/_program0
program1.after : program0 : requestedSourcePath : null
program1.after : program0 : moduleFile : true
program1.after : program0 : returned : 0
program1.after : program0 : module : null
program1.after : program1 : sourcePath : ${a.abs( '.' )}/_program1
program1.after : program1 : requestedSourcePath : null
program1.after : program1 : moduleFile : true
program1.after : program1 : returned : 1
program1.after : program1 : module : null
program1.after : program2 : sourcePath : ${a.abs( '.' )}/_program2
program1.after : program2 : requestedSourcePath : ./_program2
program1.after : program2 : moduleFile : true
program1.after : program2 : returned : 2
program1.after : program2 : module : null
program1.after : program3 : sourcePath : ${a.abs( '.' )}/_program3
program1.after : program3 : requestedSourcePath : ./_program3
program1.after : program3 : moduleFile : true
program1.after : program3 : returned : 3
program1.after : program3 : module : null
program1.end
program0.end
  `
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

  }

  /* - */

  function _program0()
  {
    console.log( 'program0.begin' );
    module.exports = 0;
    require( './_program1' );
    console.log( 'program0.end' );
  }

  /* - */

  function _program1()
  {
    let _ = require( toolsPath );
    console.log( 'program1.begin' );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program0' );
    console.log( `program1.begin : program0 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.begin : program0 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.begin : program0 : moduleFile : ${moduleFile.moduleNativeFile === module.parent}` );
    console.log( `program1.begin : program0 : returned : ${moduleFile.returned}` );
    console.log( `program1.begin : program0 : module : ${moduleFile.module}` );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program1' );
    console.log( `program1.begin : program1 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.begin : program1 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.begin : program1 : moduleFile : ${moduleFile.moduleNativeFile === module}` );
    console.log( `program1.begin : program1 : returned : ${moduleFile.returned}` );
    console.log( `program1.begin : program1 : module : ${moduleFile.module}` );

    module.exports = 1;
    require( './_program2' );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program0' );
    console.log( `program1.after : program0 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.after : program0 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.after : program0 : moduleFile : ${moduleFile.moduleNativeFile === module.parent}` );
    console.log( `program1.after : program0 : returned : ${moduleFile.returned}` );
    console.log( `program1.after : program0 : module : ${moduleFile.module}` );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program1' );
    console.log( `program1.after : program1 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.after : program1 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.after : program1 : moduleFile : ${moduleFile.moduleNativeFile === module}` );
    console.log( `program1.after : program1 : returned : ${moduleFile.returned}` );
    console.log( `program1.after : program1 : module : ${moduleFile.module}` );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program2' );
    console.log( `program1.after : program2 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.after : program2 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.after : program2 : moduleFile : ${moduleFile.moduleNativeFile === module.children[ 1 ]}` );
    console.log( `program1.after : program2 : returned : ${moduleFile.returned}` );
    console.log( `program1.after : program2 : module : ${moduleFile.module}` );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program3' );
    console.log( `program1.after : program3 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program1.after : program3 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program1.after : program3 : moduleFile : ${moduleFile.moduleNativeFile === module.children[ 1 ].children[ 0 ]}` );
    console.log( `program1.after : program3 : returned : ${moduleFile.returned}` );
    console.log( `program1.after : program3 : module : ${moduleFile.module}` );

    console.log( 'program1.end' );
  }

  /* - */

  function _program2()
  {
    const _ = _global_.wTools;
    console.log( 'program2.begin' );
    require( './_program3' );
    module.exports = 2;
    console.log( 'program2.end' );
  }

  /* - */

  function _program3()
  {
    const _ = _global_.wTools;
    console.log( 'program3' );
    module.exports = 3;

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program2' );
    console.log( `program3 : program2 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program3 : program2 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program3 : program2 : moduleFile : ${moduleFile.moduleNativeFile === module.parent}` );
    console.log( `program3 : program2 : returned : ${moduleFile.returned}` );
    console.log( `program3 : program2 : module : ${moduleFile.module}` );

    var moduleFile = _.module.fileWithResolvedPath( __dirname + '/_program3' );
    console.log( `program3 : program3 : sourcePath : ${moduleFile.sourcePath}` );
    console.log( `program3 : program3 : requestedSourcePath : ${moduleFile.requestedSourcePath}` );
    console.log( `program3 : program3 : moduleFile : ${moduleFile.moduleNativeFile === module}` );
    console.log( `program3 : program3 : returned : ${moduleFile.returned}` );
    console.log( `program3 : program3 : module : ${moduleFile.module}` );

  }

  /* - */

}

//

function inheritedModuleFilePaths( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  act({});

  return ready;

  /* - */

  function act( env )
  {

    ready.then( () =>
    {
      test.case = `basic, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program( program1 );
      a.program( program2 );
      a.program({ routine : program3, dirPath : 'dir', });
      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {

      var exp =
`
program1.paths
  ${trailOf( __dirname, a.abs( '.' ) )}
program2.paths
  ${trailOf( __dirname, a.abs( '.' ) )}
program3.paths
  ${trailOf( __dirname, a.abs( 'dir' ) )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

  }

  /* - */

  function program1()
  {
    console.log( `program1.paths\n  ${module.paths.join( '\n  ' )}` );
    require( './program2' );
  }

  /* - */

  function program2()
  {
    console.log( `program2.paths\n  ${module.paths.join( '\n  ' )}` );
    require( './dir/program3' );
  }

  /* - */

  function program3()
  {
    console.log( `program3.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* - */

  function trailOf()
  {
    let result = [];
    for( let a = arguments.length-1 ; a >= 0 ; a-- )
    {
      let filePath = arguments[ a ];
      _.arrayPrependArrayOnce( result, __.path.s.nativize( __.path.s.join( __.path.traceToRoot( filePath ), 'node_modules' ) ).reverse() );
    }
    return '  ' + result.join( '\n  ' );
  }

  /* - */

}

/* xxx : duplicate test routine in module::wIntrospectorBasics */
inheritedModuleFilePaths.description =
`
program should inherit path of parent
`

//

function modulingLogistic( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  var toolsPath = _.module.resolve( 'wTools' ); /* xxx : cover this and pathToolsGet() */
  var testingPath = _.module.resolve( 'wTesting' );
  var moduleFile = _.module.fileWithResolvedPath( testingPath );
  test.true( _.module.fileIs( moduleFile ) );
  test.true( _.module.fileUniversalIs( moduleFile ) );
  test.true( !_.module.fileNativeIs( moduleFile ) );
  test.true( _.module.fileIs( moduleFile.moduleNativeFile ) );
  test.true( !_.module.fileUniversalIs( moduleFile.moduleNativeFile ) );
  test.true( _.module.fileNativeIs( moduleFile.moduleNativeFile ) );
  test.identical( moduleFile.sourcePath, testingPath );
  test.true( _.module.is( moduleFile.module ) );

  var module = _.module.withName( 'wTools' );
  test.gt( _.lengthOf( module.files ), 100 );
  test.identical( _.lengthOf( module.files ), 169 );
  test.identical( _.lengthOf( module.alias ), 2 );
  console.log( __.path.join( toolsPath, '../../abase/l0/l0/Global.s' ) );
  test.true( _.module.filesMap.has( __.path.join( toolsPath, '../../Tools.s' ) ) );
  test.true( module.files.has( __.path.join( toolsPath, '../../Tools.s' ) ) );
  test.true( _.module.filesMap.has( __.path.join( toolsPath, '../../abase/l0/l0/Global.s' ) ) );
  test.true( module.files.has( __.path.join( toolsPath, '../../abase/l0/l0/Global.s' ) ) );
  var module2 = _.module.withName( 'wTools' );
  test.true( module === module2 );
  var module2 = _.module.withName( 'wtools' );
  test.true( module === module2 );

  var module = _.module.withPath( testingPath );
  // test.identical( _.lengthOf( module.files ), 2 );
  test.identical( _.lengthOf( module.alias ), 2 );
  // var exp = [ 'testing/entry/Main.s', 'testing/include/Top.s' ] ;
  // var files = __.select( [ ... module.files.values() ], '*/sourcePath' );
  // test.identical( __.path.s.relative( testingPath + '/../../..', files ), exp );
  // xxx
  var module2 = _.module.withName( 'wTesting' );
  test.true( module === module2 );
  var module2 = _.module.withName( 'wtesting' );
  test.true( module === module2 );

  test.identical( _.lengthOf( _.module._modulesToPredeclare ), 0 );
  test.ge( _.lengthOf( _.module.modulesMap ), 4 );

  console.log( 'lengthOf( _modulesToPredeclare )', _.lengthOf( _.module._modulesToPredeclare ) );
  console.log( 'lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
  console.log( 'lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
  console.log( 'lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
  console.log( 'lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );
  var diff = _.arraySet.diff_( null, [ ... _.module.filesMap.keys() ], [ ... _.module.withName( 'wTools' ).files.keys() ] )
  console.log( `filesMap but tools.files\n  ${diff.join( '\n  ' )}` );

  act({});

  return ready;

  /* - xxx */

  function act( env )
  {

    ready.then( () =>
    {
      test.case = `external program, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program
      ({
        routine : program1,
      });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      /*
      extra moddule file is program
      */
      var exp =
`
lengthOf( _modulesToPredeclare ) 0
lengthOf( predeclaredWithNameMap ) ${_.lengthOf( _.module.predeclaredWithNameMap )}
lengthOf( predeclaredWithEntryPathMap ) ${_.lengthOf( _.module.predeclaredWithEntryPathMap )}
lengthOf( modulesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).alias )}
lengthOf( filesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).files )+1}
module.fileIs( moduleFile ) true
module.fileUniversalIs( moduleFile ) true
module.fileNativeIs( moduleFile ) false
module.fileIs( moduleFile.moduleNativeFile ) true
module.fileUniversalIs( moduleFile.moduleNativeFile ) false
module.fileNativeIs( moduleFile.moduleNativeFile ) true
moduleFile.sourcePath ${a.path.join( testingPath, '../Main.s' )}
moduleFile.downFile.sourcePath ${a.abs( 'program1' )}
moduleFile.downFile.module null
module.is( moduleFile.module ) true
filesOfTesting testing/entry/Main.s testing/include/Top.s ../abase/l0/l0/Global.s
lengthOf( _modulesToPredeclare ) 0
lengthOf( predeclaredWithNameMap ) ${_.lengthOf( _.module.predeclaredWithNameMap )}
lengthOf( predeclaredWithEntryPathMap ) ${_.lengthOf( _.module.predeclaredWithEntryPathMap )}
lengthOf( modulesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).alias ) + _.lengthOf( _.module.withName( 'wTesting' ).alias )}
modulesMap wTools wTools wTesting wTesting
`
// xxx : add
// lengthOf( filesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).files ) + _.lengthOf( _.module.withName( 'wTesting' ).files)}
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

  }

  /* - */

  function program1()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    console.log( 'lengthOf( _modulesToPredeclare )', _.lengthOf( _.module._modulesToPredeclare ) );
    console.log( 'lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
    console.log( 'lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
    console.log( 'lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
    console.log( 'lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );

    let __ = _.include( 'wTesting' );

    var testingPath = _.module.resolve( 'wTesting' );
    var moduleFile = _.module.fileWithResolvedPath( testingPath );
    console.log( `module.fileIs( moduleFile )`, _.module.fileIs( moduleFile ) );
    console.log( `module.fileUniversalIs( moduleFile )`, _.module.fileUniversalIs( moduleFile ) );
    console.log( `module.fileNativeIs( moduleFile )`, _.module.fileNativeIs( moduleFile ) );
    console.log( `module.fileIs( moduleFile.moduleNativeFile )`, _.module.fileIs( moduleFile.moduleNativeFile ) );
    console.log( `module.fileUniversalIs( moduleFile.moduleNativeFile )`, _.module.fileUniversalIs( moduleFile.moduleNativeFile ) );
    console.log( `module.fileNativeIs( moduleFile.moduleNativeFile )`, _.module.fileNativeIs( moduleFile.moduleNativeFile ) );
    console.log( `moduleFile.sourcePath`, moduleFile.sourcePath );
    console.log( `moduleFile.downFile.sourcePath`, moduleFile.downFile.sourcePath );
    console.log( `moduleFile.downFile.module`, moduleFile.downFile.module );
    console.log( `module.is( moduleFile.module )`, _.module.is( moduleFile.module ) );

    var module = _.module.withPath( testingPath );
    var filesOfTesting = __.path.s.relative( testingPath + '/../../..', __.select( [ ... module.files.values() ], '*/sourcePath' ) );
    console.log( 'filesOfTesting', filesOfTesting.join( ' ' ) );

    console.log( 'lengthOf( _modulesToPredeclare )', _.lengthOf( _.module._modulesToPredeclare ) );
    console.log( 'lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
    console.log( 'lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
    console.log( 'lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
    // console.log( 'lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );
    console.log( 'modulesMap', [ ... _.module.modulesMap.values() ].map( ( m ) => m.name ).join( ' ' ) );

  }

}

modulingLogistic.description =
`
- relations between module files is sane
`

//

function predeclareBasic( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  act({});

  return ready;

  /* - xxx */

  function act( env )
  {

    /* */

    ready.then( () =>
    {
      test.case = `predeclare before, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program( main );

      a.program
      ({
        routine : program1,
        dirPath : 'dir',
      });

      a.program( program2 )

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      /*
      extra module file is program
      */
      var exp =
`
main.before / lengthOf( predeclaredWithNameMap ) ${_.lengthOf( _.module.predeclaredWithNameMap )}
main.before / lengthOf( predeclaredWithEntryPathMap ) ${_.lengthOf( _.module.predeclaredWithEntryPathMap )}
main.before / lengthOf( modulesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).alias )}
main.before / lengthOf( filesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).files ) + 1}
main.before / filesMap but tools.files
  ${a.abs( 'main' ) }
main.mid / predeclared.program1 : Module.constructible
main.mid / predeclared.program2 : Module.constructible
main.mid / lengthOf( predeclaredWithNameMap ) ${_.lengthOf( _.module.predeclaredWithNameMap ) + 2}
main.mid / lengthOf( predeclaredWithEntryPathMap ) ${_.lengthOf( _.module.predeclaredWithEntryPathMap ) + 2}
main.mid / lengthOf( modulesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).alias )}
main.mid / lengthOf( filesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).files ) + 1}
main.mid / isIncluded( Program1 ) false
main.mid / isIncluded( Program2 ) false
program1 / isIncluded( Program1 ) true
program1 / isIncluded( Program2 ) false
program2 / isIncluded( Program1 ) true
program2 / isIncluded( Program2 ) true
main.after / isIncluded( Program1 ) true
main.after / isIncluded( Program2 ) true
Program1
  ${a.abs( 'dir/program1' )}
Program2
  ${a.abs( 'program2' )}
orphans
  ${a.abs( 'main' )}
main.after / lengthOf( predeclaredWithNameMap ) ${_.lengthOf( _.module.predeclaredWithNameMap ) + 2}
main.after / lengthOf( predeclaredWithEntryPathMap ) ${_.lengthOf( _.module.predeclaredWithEntryPathMap ) + 2}
main.after / lengthOf( modulesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).alias ) + 2}
main.after / lengthOf( filesMap ) ${_.lengthOf( _.module.withName( 'wTools' ).files ) + 3}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

  }

  /* - */

  function main()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    console.log( 'main.before / lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
    console.log( 'main.before / lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
    console.log( 'main.before / lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
    console.log( 'main.before / lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );
    var diff = _.arraySet.diff_( null, [ ... _.module.filesMap.keys() ], [ ... _.module.withName( 'wTools' ).files.keys() ] )
    console.log( `main.before / filesMap but tools.files\n  ${diff.join( '\n  ' )}` );

    _.module.predeclare( 'Program1', __dirname + '/dir/program1' );
    _.module.predeclare( 'Program2', __dirname + '/program2/' );

    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/dir/program1/' ) );
    console.log( `main.mid / predeclared.program1 : ${_.entity.strType( module )}` );
    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/program2' ) );
    console.log( `main.mid / predeclared.program2 : ${_.entity.strType( module )}` );

    console.log( 'main.mid / lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
    console.log( 'main.mid / lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
    console.log( 'main.mid / lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
    console.log( 'main.mid / lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );

    console.log( 'main.mid / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'main.mid / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );

    require( './dir/program1' );

    console.log( 'main.after / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'main.after / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );

    var files = [ ... _.module.withName( 'Program1' ).files.keys() ];
    console.log( `Program1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Program2' ).files.keys() ];
    console.log( `Program2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

    console.log( 'main.after / lengthOf( predeclaredWithNameMap )', _.lengthOf( _.module.predeclaredWithNameMap ) );
    console.log( 'main.after / lengthOf( predeclaredWithEntryPathMap )', _.lengthOf( _.module.predeclaredWithEntryPathMap ) );
    console.log( 'main.after / lengthOf( modulesMap )', _.lengthOf( _.module.modulesMap ) );
    console.log( 'main.after / lengthOf( filesMap )', _.lengthOf( _.module.filesMap ) );

  }

  /* - */

  function program1()
  {
    let _ = wTools;
    console.log( 'program1 / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'program1 / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
    require( '../program2' );
  }

  /* - */

  function program2()
  {
    let _ = wTools;
    console.log( 'program2 / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'program2 / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
  }

  /* - */

}

//

function predeclareMain( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  special({ includingWith : 'require' });
  before({ includingWith : 'require' });
  before({ includingWith : 'include' });
  after({ includingWith : 'require', order : 'trp' }); /* tools, require, predeclare */
  after({ includingWith : 'require', order : 'rtp' }); /* require, tools, predeclare */
  after({ includingWith : 'require', order : 'prt' }); /* predeclare, require, tools */

  return ready;

  /* - xxx2 */

  function special( env )
  {

    /* */

    ready.then( () =>
    {
      test.case = `same entry path for both modules, ${__.entity.exportStringSolo( env, { level : 1 } )}`;
      var programPath = a.program( mainMultipleDeclare );
      a.program( common );
      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp = `Module Common2 is trying to register entry path registered by module Common1`;
      test.true( _.strHas( op.output, exp ) );
      var exp = `Entry path : ${a.abs( 'common' )}`;
      test.true( _.strHas( op.output, exp ) );
      test.nil( op.exitCode, 0 );
      return op;
    });

    /* */

  }

  /* - */

  function before( env )
  {

    /* */

    ready.then( () =>
    {
      test.case = `before, single level, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainSingleBefore, locals : _.mapExtend( null, env ) });
      a.program({ routine : single1, locals : _.mapExtend( null, env ) });
      a.program({ routine : single2, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
main.mid / predeclared.single1 : Module.constructible
main.mid / predeclared.single2 : Module.constructible
main.mid / isIncluded( Single1 ) false
main.mid / isIncluded( Single2 ) false
single1 / isIncluded( Single1 ) true
single1 / isIncluded( Single2 ) false
single2 / isIncluded( Single1 ) true
single2 / isIncluded( Single2 ) true
main.after / isIncluded( Single1 ) true
main.after / isIncluded( Single2 ) true
Single1
  ${a.abs( 'single1' )}
Single2
  ${a.abs( 'single2' )}
orphans
  ${a.abs( 'mainSingleBefore' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `before, deep, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainDeepBefore, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep1a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep1b, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep1c, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep1d, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep1e, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
main.mid / isIncluded( Deep1b ) false
main.mid / isIncluded( Deep1d ) false
deep1a / isIncluded( Deep1b ) false
deep1a / isIncluded( Deep1d ) false
deep1b / isIncluded( Deep1b ) true
deep1b / isIncluded( Deep1d ) false
deep1c / isIncluded( Deep1b ) true
deep1c / isIncluded( Deep1d ) false
deep1d / isIncluded( Deep1b ) true
deep1d / isIncluded( Deep1d ) true
deep1e / isIncluded( Deep1b ) true
deep1e / isIncluded( Deep1d ) true
main.after / isIncluded( Deep1b ) true
main.after / isIncluded( Deep1d ) true
Deep1b
  ${a.abs( 'deep1b' )}
  ${a.abs( 'deep1c' )}
Deep1d
  ${a.abs( 'deep1d' )}
  ${a.abs( 'deep1e' )}
orphans
  ${a.abs( 'mainDeepBefore' )}
  ${a.abs( 'deep1a' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () => /* xxx : implement after */
    {
      test.case = `before, common sub file, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBeforeCommonSubFile, locals : _.mapExtend( null, env ) });
      a.program({ routine : common, locals : _.mapExtend( null, env ) });
      a.program({ routine : common1, locals : _.mapExtend( null, env ) });
      a.program({ routine : common2, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
common
common1 abc
Common1 abc
common2 abc
Common2 abc
Common1
  ${a.abs( 'common1' )}
  ${a.abs( 'common' )}
Common2
  ${a.abs( 'common2' )}
  ${a.abs( 'common' )}
orphans
  ${a.abs( 'mainBeforeCommonSubFile' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () => /* xxx : implement after */
    {
      test.case = `before, common sub file deep, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBeforeCommonSubFileDeep, locals : _.mapExtend( null, env ) });
      a.program({ routine : common, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep3a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep3b, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
common
deep2b.1 abc
deep2b.2 abc
deep2a abc
Deep2 abc
deep3b.1 abc
deep3b.2 abc
deep3a abc
Deep3 abc
deep2b.upFiles
  ${a.abs( 'common' )}
deep3b.upFiles
  ${a.abs( 'common' )}
common.downFiles
  ${a.abs( 'deep2b' )}
  ${a.abs( 'deep3b' )}
Deep2
  ${a.abs( 'deep2a' )}
  ${a.abs( 'deep2b' )}
  ${a.abs( 'common' )}
Deep3
  ${a.abs( 'deep3a' )}
  ${a.abs( 'deep3b' )}
  ${a.abs( 'common' )}
orphans
  ${a.abs( 'mainBeforeCommonSubFileDeep' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `before, branching1, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBranchingBefore1, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branchingCommon, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
main.mid / isIncluded( Branching1 ) false
main.mid / isIncluded( Branching2 ) false
branching1a
branching1b
branchingCommon
branching2b
branching2a
main.after / isIncluded( Branching1 ) true
main.after / isIncluded( Branching2 ) true
Branching1
  ${a.abs( 'branching1a' )}
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
Branching2
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2a' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
orphans
  ${a.abs( 'mainBranchingBefore1' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `before, branching2, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBranchingBefore2, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branchingCommon, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
main.mid / isIncluded( Branching1 ) false
main.mid / isIncluded( Branching2 ) false
branching2a
branching2b
branchingCommon
branching1b
branching1a
main.after / isIncluded( Branching1 ) true
main.after / isIncluded( Branching2 ) true
Branching1
  ${a.abs( 'branching1a' )}
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
Branching2
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2a' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
orphans
  ${a.abs( 'mainBranchingBefore2' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

  }

  /* - */

  function after( env )
  {

    ready.then( () =>
    {
      test.case = `after, single, top first, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainSingleAfterTopFirst, locals : _.mapExtend( null, env ) });
      a.program({ routine : singleAfter1, locals : _.mapExtend( null, env ) });
      a.program({ routine : singleAfter2, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
singleAfter1
singleAfter2
main.after / predeclared.singleAfter1 : Module.constructible
main.after / predeclared.singleAfter2 : Module.constructible
main.after / isIncluded( Single1 ) true
main.after / isIncluded( Single2 ) true
Single1
  ${a.abs( 'singleAfter1' )}
Single2
  ${a.abs( 'singleAfter2' )}
orphans
  ${a.abs( 'mainSingleAfterTopFirst' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, single, bottom first, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainSingleAfterBottomFirst, locals : _.mapExtend( null, env ) });
      a.program({ routine : singleAfter1, locals : _.mapExtend( null, env ) });
      a.program({ routine : singleAfter2, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
singleAfter1
singleAfter2
main.after / predeclared.singleAfter1 : Module.constructible
main.after / predeclared.singleAfter2 : Module.constructible
main.after / isIncluded( Single1 ) true
main.after / isIncluded( Single2 ) true
Single1
  ${a.abs( 'singleAfter1' )}
Single2
  ${a.abs( 'singleAfter2' )}
orphans
  ${a.abs( 'mainSingleAfterBottomFirst' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, deep, b, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainDeepAfterB, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11b, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11c, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11d, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11e, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
deep11a
deep11b
deep11c
deep11d
deep11e
main.after / isIncluded( Deep1b ) true
main.after / isIncluded( Deep1d ) true
Deep1b
  ${a.abs( 'deep11b' )}
  ${a.abs( 'deep11c' )}
Deep1d
  ${a.abs( 'deep11d' )}
  ${a.abs( 'deep11e' )}
orphans
  ${a.abs( 'mainDeepAfterB' )}
  ${a.abs( 'deep11a' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, deep, d, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainDeepAfterD, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11b, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11c, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11d, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep11e, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
deep11a
deep11b
deep11c
deep11d
deep11e
main.after / isIncluded( Deep1b ) true
main.after / isIncluded( Deep1d ) true
Deep1b
  ${a.abs( 'deep11b' )}
  ${a.abs( 'deep11c' )}
Deep1d
  ${a.abs( 'deep11d' )}
  ${a.abs( 'deep11e' )}
orphans
  ${a.abs( 'mainDeepAfterD' )}
  ${a.abs( 'deep11a' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, common sub file, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainAfterCommonSubFile, locals : _.mapExtend( null, env ) });
      a.program({ routine : common, locals : _.mapExtend( null, env ) });
      a.program({ routine : common1, locals : _.mapExtend( null, env ) });
      a.program({ routine : common2, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
common
common1 abc
Common1 abc
common2 abc
Common2 abc
common1.upFiles
  ${a.abs( 'common' )}
common2.upFiles
  ${a.abs( 'common' )}
common.downFiles
  ${a.abs( 'common1' )}
  ${a.abs( 'common2' )}
Common1
  ${a.abs( 'common1' )}
  ${a.abs( 'common' )}
Common2
  ${a.abs( 'common2' )}
  ${a.abs( 'common' )}
orphans
  ${a.abs( 'mainAfterCommonSubFile' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, common sub file deep, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainAfterCommonSubFileDeep, locals : _.mapExtend( null, env ) });
      a.program({ routine : common, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep3a, locals : _.mapExtend( null, env ) });
      a.program({ routine : deep3b, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
common
deep2b.1 abc
deep2b.2 abc
deep2a abc
Deep2 abc
deep3b.1 abc
deep3b.2 abc
deep3a abc
Deep3 abc
deep2b.upFiles
  ${a.abs( 'common' )}
deep3b.upFiles
  ${a.abs( 'common' )}
common.downFiles
  ${a.abs( 'deep2b' )}
  ${a.abs( 'deep3b' )}
Deep2
  ${a.abs( 'deep2a' )}
  ${a.abs( 'deep2b' )}
  ${a.abs( 'common' )}
Deep3
  ${a.abs( 'deep3a' )}
  ${a.abs( 'deep3b' )}
  ${a.abs( 'common' )}
orphans
  ${a.abs( 'mainAfterCommonSubFileDeep' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, branching1, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBranchingAfter1, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branchingCommon, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
branching1a
branching1b
branchingCommon
branching2b
branching2a
main.after / isIncluded( Branching1 ) true
main.after / isIncluded( Branching2 ) true
Branching1
  ${a.abs( 'branching1a' )}
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
Branching2
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2a' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
orphans
  ${a.abs( 'mainBranchingAfter1' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

    ready.then( () =>
    {
      test.case = `after, branching2, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program({ routine : mainBranchingAfter2, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching1b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2a, locals : _.mapExtend( null, env ) });
      a.program({ routine : branching2b, locals : _.mapExtend( null, env ) });
      a.program({ routine : branchingCommon, locals : _.mapExtend( null, env ) });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
branching2a
branching2b
branchingCommon
branching1b
branching1a
main.after / isIncluded( Branching1 ) true
main.after / isIncluded( Branching2 ) true
Branching1
  ${a.abs( 'branching1a' )}
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
Branching2
  ${a.abs( 'branching1b' )}
  ${a.abs( 'branching2a' )}
  ${a.abs( 'branching2b' )}
  ${a.abs( 'branchingCommon' )}
orphans
  ${a.abs( 'mainBranchingAfter2' )}
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

  }

  /* - */

  function mainSingleBefore()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Single1', __dirname + '/single1' );
    _.module.predeclare( 'Single2', __dirname + '/single2/' );

    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/single1' ) );
    console.log( `main.mid / predeclared.single1 : ${_.entity.strType( module )}` );
    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/single2' ) );
    console.log( `main.mid / predeclared.single2 : ${_.entity.strType( module )}` );

    console.log( 'main.mid / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'main.mid / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );

    if( includingWith === 'require' )
    require( './single1' );
    else
    _.include( 'Single1' );

    console.log( 'main.after / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'main.after / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );

    var files = [ ... _.module.withName( 'Single1' ).files.keys() ];
    console.log( `Single1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Single2' ).files.keys() ];
    console.log( `Single2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function single1()
  {
    let _ = wTools;
    console.log( 'single1 / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'single1 / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );

    if( includingWith === 'require' )
    require( './single2' );
    else
    _.include( 'Single2' );

  }

  /* - */

  function single2()
  {
    let _ = wTools;
    console.log( 'single2 / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'single2 / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );
  }

  /* - */

  function mainSingleAfterTopFirst()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './singleAfter1' );
      _.module.predeclare( 'Single1', __dirname + '/singleAfter1' );
      _.module.predeclare( 'Single2', __dirname + '/singleAfter2/' );
    }
    else if( order === 'rtp' )
    {
      require( './singleAfter1' );
      _ = require( toolsPath );
      _.module.predeclare( 'Single1', __dirname + '/singleAfter1' );
      _.module.predeclare( 'Single2', __dirname + '/singleAfter2/' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Single1' ] = { entryPath : __dirname + '/singleAfter1' };
      _.module._modulesToPredeclare[ 'Single2' ] = { entryPath : __dirname + '/singleAfter2/' };
      require( './singleAfter1' );
      _ = require( toolsPath );
    }

    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/singleAfter1' ) );
    console.log( `main.after / predeclared.singleAfter1 : ${_.entity.strType( module )}` );
    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/singleAfter2' ) );
    console.log( `main.after / predeclared.singleAfter2 : ${_.entity.strType( module )}` );

    console.log( 'main.after / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'main.after / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );

    var files = [ ... _.module.withName( 'Single1' ).files.keys() ];
    console.log( `Single1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Single2' ).files.keys() ];
    console.log( `Single2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainSingleAfterBottomFirst()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './singleAfter1' );
      _.module.predeclare( 'Single2', __dirname + '/singleAfter2/' );
      _.module.predeclare( 'Single1', __dirname + '/singleAfter1' );
    }
    else if( order === 'rtp' )
    {
      require( './singleAfter1' );
      _ = require( toolsPath );
      _.module.predeclare( 'Single2', __dirname + '/singleAfter2/' );
      _.module.predeclare( 'Single1', __dirname + '/singleAfter1' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Single2' ] = { entryPath : __dirname + '/singleAfter2/' };
      _.module._modulesToPredeclare[ 'Single1' ] = { entryPath : __dirname + '/singleAfter1' };
      require( './singleAfter1' );
      _ = require( toolsPath );
    }

    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/singleAfter1' ) );
    console.log( `main.after / predeclared.singleAfter1 : ${_.entity.strType( module )}` );
    var module = _.module.predeclaredWithEntryPathMap.get( _.path.canonize( __dirname + '/singleAfter2' ) );
    console.log( `main.after / predeclared.singleAfter2 : ${_.entity.strType( module )}` );

    console.log( 'main.after / isIncluded( Single1 )', _.module.isIncluded( 'Single1' ) );
    console.log( 'main.after / isIncluded( Single2 )', _.module.isIncluded( 'Single2' ) );

    var files = [ ... _.module.withName( 'Single1' ).files.keys() ];
    console.log( `Single1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Single2' ).files.keys() ];
    console.log( `Single2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function singleAfter1()
  {
    console.log( 'singleAfter1' );
    require( './singleAfter2' );
  }

  /* - */

  function singleAfter2()
  {
    console.log( 'singleAfter2' );
  }

  /* - */

  function mainDeepBefore()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Deep1b', __dirname + '/deep1b' );
    _.module.predeclare( 'Deep1d', __dirname + '/deep1d' );

    console.log( 'main.mid / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'main.mid / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    require( './deep1a' );

    console.log( 'main.after / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'main.after / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    var files = [ ... _.module.withName( 'Deep1b' ).files.keys() ];
    console.log( `Deep1b\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Deep1d' ).files.keys() ];
    console.log( `Deep1d\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function deep1a()
  {
    let _ = wTools;
    console.log( 'deep1a / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'deep1a / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    if( includingWith === 'require' )
    require( './deep1b' );
    else
    _.include( 'Deep1b' );

  }

  /* - */

  function deep1b()
  {
    let _ = wTools;
    console.log( 'deep1b / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'deep1b / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    require( './deep1c' );

  }

  /* - */

  function deep1c()
  {
    let _ = wTools;
    console.log( 'deep1c / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'deep1c / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    if( includingWith === 'require' )
    require( './deep1d' );
    else
    _.include( 'Deep1d' );

  }

  /* - */

  function deep1d()
  {
    let _ = wTools;
    console.log( 'deep1d / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'deep1d / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    require( './deep1e' );

  }

  /* - */

  function deep1e()
  {
    let _ = wTools;
    console.log( 'deep1e / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'deep1e / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );
  }

  /* - */

  function mainDeepAfterB()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './deep11a' );
      _.module.predeclare( 'Deep1b', __dirname + '/deep11b' );
      _.module.predeclare( 'Deep1d', __dirname + '/deep11d' );
    }
    else if( order === 'rtp' )
    {
      require( './deep11a' );
      _ = require( toolsPath );
      _.module.predeclare( 'Deep1b', __dirname + '/deep11b' );
      _.module.predeclare( 'Deep1d', __dirname + '/deep11d' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Deep1b' ] = { entryPath : __dirname + '/deep11b' };
      _.module._modulesToPredeclare[ 'Deep1d' ] = { entryPath : __dirname + '/deep11d' };
      require( './deep11a' );
      _ = require( toolsPath );
    }

    console.log( 'main.after / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'main.after / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    var files = [ ... _.module.withName( 'Deep1b' ).files.keys() ];
    console.log( `Deep1b\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Deep1d' ).files.keys() ];
    console.log( `Deep1d\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainDeepAfterD()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './deep11a' );
      _.module.predeclare( 'Deep1d', __dirname + '/deep11d' );
      _.module.predeclare( 'Deep1b', __dirname + '/deep11b' );
    }
    else if( order === 'rtp' )
    {
      require( './deep11a' );
      _ = require( toolsPath );
      _.module.predeclare( 'Deep1d', __dirname + '/deep11d' );
      _.module.predeclare( 'Deep1b', __dirname + '/deep11b' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Deep1d' ] = { entryPath : __dirname + '/deep11d' };
      _.module._modulesToPredeclare[ 'Deep1b' ] = { entryPath : __dirname + '/deep11b' };
      require( './deep11a' );
      _ = require( toolsPath );
    }

    console.log( 'main.after / isIncluded( Deep1b )', _.module.isIncluded( 'Deep1b' ) );
    console.log( 'main.after / isIncluded( Deep1d )', _.module.isIncluded( 'Deep1d' ) );

    var files = [ ... _.module.withName( 'Deep1b' ).files.keys() ];
    console.log( `Deep1b\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Deep1d' ).files.keys() ];
    console.log( `Deep1d\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function deep11a()
  {
    console.log( 'deep11a' );
    require( './deep11b' );
  }

  /* - */

  function deep11b()
  {
    console.log( 'deep11b' );
    require( './deep11c' );
  }

  /* - */

  function deep11c()
  {
    console.log( 'deep11c' );
    require( './deep11d' );
  }

  /* - */

  function deep11d()
  {
    console.log( 'deep11d' );
    require( './deep11e' );
  }

  /* - */

  function deep11e()
  {
    console.log( 'deep11e' );
  }

  /* - */

  function mainMultipleDeclare()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Common1', __dirname + '/common' );
    _.module.predeclare( 'Common2', __dirname + '/common' );

  }

  /* - */

  function mainBeforeCommonSubFile()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Common1', __dirname + '/common1' );
    _.module.predeclare( 'Common2', __dirname + '/common2' );

    if( includingWith === 'require' )
    console.log( 'Common1', require( './common1' ) );
    else
    console.log( 'Common1', _.include( 'Common1' ) );

    if( includingWith === 'require' )
    console.log( 'Common2', require( './common2' ) );
    else
    console.log( 'Common2', _.include( 'Common2' ) );

    var files = [ ... _.module.withName( 'Common1' ).files.keys() ];
    console.log( `Common1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Common2' ).files.keys() ];
    console.log( `Common2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainAfterCommonSubFile()
  {
    let _;

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      console.log( 'Common1', require( './common1' ) );
      console.log( 'Common2', require( './common2' ) );
      _.module.predeclare( 'Common1', __dirname + '/common1' );
      _.module.predeclare( 'Common2', __dirname + '/common2' );
    }
    else if( order === 'rtp' )
    {
      console.log( 'Common1', require( './common1' ) );
      console.log( 'Common2', require( './common2' ) );
      _ = require( toolsPath );
      _.module.predeclare( 'Common1', __dirname + '/common1' );
      _.module.predeclare( 'Common2', __dirname + '/common2' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Common1' ] = { entryPath : __dirname + '/common1' };
      _.module._modulesToPredeclare[ 'Common2' ] = { entryPath : __dirname + '/common2' };
      console.log( 'Common1', require( './common1' ) );
      console.log( 'Common2', require( './common2' ) );
      _ = require( toolsPath );
    }

    var file = _.module.fileWith( './common1' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `common1.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './common2' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `common2.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './common' );
    var files = [ ... file.downFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `common.downFiles\n  ${files.sort().join( '\n  ' )}` );

    var files = [ ... _.module.withName( 'Common1' ).files.keys() ];
    console.log( `Common1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Common2' ).files.keys() ];
    console.log( `Common2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function common()
  {
    console.log( 'common' );
    module.exports = 'abc';
  }

  /* - */

  function common1()
  {
    let result = require( './common' );
    console.log( 'common1', result );
    module.exports = result;
  }

  /* - */

  function common2()
  {
    let result = require( './common' );
    console.log( 'common2', result );
    module.exports = result;
  }

  /* - */

  function mainBeforeCommonSubFileDeep()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Deep2', __dirname + '/deep2a' );
    _.module.predeclare( 'Deep3', __dirname + '/deep3a' );

    if( includingWith === 'require' )
    console.log( 'Deep2', require( './deep2a' ) );
    else
    console.log( 'Deep2', _.include( 'Deep2' ) );

    if( includingWith === 'require' )
    console.log( 'Deep3', require( './deep3a' ) );
    else
    console.log( 'Deep3', _.include( 'Deep3' ) );

    var file = _.module.fileWith( './deep2b' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `deep2b.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './deep3b' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `deep3b.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './common' );
    var files = [ ... file.downFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `common.downFiles\n  ${files.sort().join( '\n  ' )}` );

    var files = [ ... _.module.withName( 'Deep2' ).files.keys() ];
    console.log( `Deep2\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Deep3' ).files.keys() ];
    console.log( `Deep3\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainAfterCommonSubFileDeep()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      console.log( 'Deep2', require( './deep2a' ) );
      console.log( 'Deep3', require( './deep3a' ) );
      _.module.predeclare( 'Deep2', __dirname + '/deep2a' );
      _.module.predeclare( 'Deep3', __dirname + '/deep3a' );
    }
    else if( order === 'rtp' )
    {
      console.log( 'Deep2', require( './deep2a' ) );
      console.log( 'Deep3', require( './deep3a' ) );
      _ = require( toolsPath );
      _.module.predeclare( 'Deep2', __dirname + '/deep2a' );
      _.module.predeclare( 'Deep3', __dirname + '/deep3a' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Deep2' ] = { entryPath : __dirname + '/deep2a' };
      _.module._modulesToPredeclare[ 'Deep3' ] = { entryPath : __dirname + '/deep3a' };
      console.log( 'Deep2', require( './deep2a' ) );
      console.log( 'Deep3', require( './deep3a' ) );
      _ = require( toolsPath );
    }

    var file = _.module.fileWith( './deep2b' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `deep2b.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './deep3b' );
    var files = [ ... file.upFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `deep3b.upFiles\n  ${files.join( '\n  ' )}` );
    var file = _.module.fileWith( './common' );
    var files = [ ... file.downFiles.values() ].map( ( file ) => file.sourcePath );
    console.log( `common.downFiles\n  ${files.sort().join( '\n  ' )}` );

    var files = [ ... _.module.withName( 'Deep2' ).files.keys() ];
    console.log( `Deep2\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Deep3' ).files.keys() ];
    console.log( `Deep3\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function deep2a()
  {
    let result = require( './deep2b' );
    console.log( 'deep2a', result );
    module.exports = result;
  }

  /* - */

  function deep2b()
  {
    let result = require( './common' );
    console.log( 'deep2b.1', result );
    let result2 = require( './common' );
    console.log( 'deep2b.2', result2 );
    module.exports = result;
  }

  /* - */

  function deep3a()
  {
    let result = require( './deep3b' );
    console.log( 'deep3a', result );
    module.exports = result;
  }

  /* - */

  function deep3b()
  {
    let result = require( './common' );
    console.log( 'deep3b.1', result );
    let result2 = require( './common' );
    console.log( 'deep3b.2', result2 );
    module.exports = result;
  }

  /* - */

  function mainBranchingBefore1()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
    _.module.predeclare( 'Branching2', __dirname + '/branching2a' );

    console.log( 'main.mid / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.mid / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    if( includingWith === 'require' )
    require( './branching1a' );
    else
    _.include( 'Branching1' );

    if( includingWith === 'require' )
    require( './branching2a' );
    else
    _.include( 'Branching2' );

    console.log( 'main.after / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.after / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    var files = [ ... _.module.withName( 'Branching1' ).files.keys() ].sort();
    console.log( `Branching1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Branching2' ).files.keys() ].sort();
    console.log( `Branching2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainBranchingBefore2()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );

    _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
    _.module.predeclare( 'Branching2', __dirname + '/branching2a' );

    console.log( 'main.mid / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.mid / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    if( includingWith === 'require' )
    require( './branching2a' );
    else
    _.include( 'Branching2' );

    if( includingWith === 'require' )
    require( './branching1a' );
    else
    _.include( 'Branching1' );

    console.log( 'main.after / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.after / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    var files = [ ... _.module.withName( 'Branching1' ).files.keys() ].sort();
    console.log( `Branching1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Branching2' ).files.keys() ].sort();
    console.log( `Branching2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainBranchingAfter1()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './branching1a' );
      require( './branching2a' );
      _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
      _.module.predeclare( 'Branching2', __dirname + '/branching2a' );
    }
    else if( order === 'rtp' )
    {
      require( './branching1a' );
      require( './branching2a' );
      _ = require( toolsPath );
      _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
      _.module.predeclare( 'Branching2', __dirname + '/branching2a' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Branching1' ] = { entryPath : __dirname + '/branching1a' };
      _.module._modulesToPredeclare[ 'Branching2' ] = { entryPath : __dirname + '/branching2a' };
      require( './branching1a' );
      require( './branching2a' );
      _ = require( toolsPath );
    }

    console.log( 'main.after / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.after / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    var files = [ ... _.module.withName( 'Branching1' ).files.keys() ].sort();
    console.log( `Branching1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Branching2' ).files.keys() ].sort();
    console.log( `Branching2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function mainBranchingAfter2()
  {

    if( order === 'trp' )
    {
      _ = require( toolsPath );
      require( './branching2a' );
      require( './branching1a' );
      _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
      _.module.predeclare( 'Branching2', __dirname + '/branching2a' );
    }
    else if( order === 'rtp' )
    {
      require( './branching2a' );
      require( './branching1a' );
      _ = require( toolsPath );
      _.module.predeclare( 'Branching1', __dirname + '/branching1a' );
      _.module.predeclare( 'Branching2', __dirname + '/branching2a' );
    }
    else if( order === 'prt' )
    {
      _ = globalThis.wTools = globalThis.wTools || Object.create( null );
      _.module = _.module || Object.create( null );
      _.module._modulesToPredeclare = _.module._modulesToPredeclare || Object.create( null );
      _.module._modulesToPredeclare[ 'Branching1' ] = { entryPath : __dirname + '/branching1a' };
      _.module._modulesToPredeclare[ 'Branching2' ] = { entryPath : __dirname + '/branching2a' };
      require( './branching2a' );
      require( './branching1a' );
      _ = require( toolsPath );
    }

    console.log( 'main.after / isIncluded( Branching1 )', _.module.isIncluded( 'Branching1' ) );
    console.log( 'main.after / isIncluded( Branching2 )', _.module.isIncluded( 'Branching2' ) );

    var files = [ ... _.module.withName( 'Branching1' ).files.keys() ].sort();
    console.log( `Branching1\n  ${files.join( '\n  ' )}` );
    var files = [ ... _.module.withName( 'Branching2' ).files.keys() ].sort();
    console.log( `Branching2\n  ${files.join( '\n  ' )}` );
    var orphans = [ ... _.module.filesMap.values() ].filter( ( file ) => !file.module ).map( ( file ) => file.sourcePath );
    console.log( `orphans\n  ${orphans.join( '\n  ' )}` );

  }

  /* - */

  function branching1a()
  {
    console.log( 'branching1a' );
    require( './branching1b' );
  }

  /* - */

  function branching1b()
  {
    console.log( 'branching1b' );
    require( './branchingCommon' );
    require( './branching2b' );
  }

  /* - */

  function branching2a()
  {
    console.log( 'branching2a' );
    require( './branching2b' );
  }

  /* - */

  function branching2b()
  {
    console.log( 'branching2b' );
    require( './branchingCommon' );
    require( './branching1b' );
  }

  /* - */

  function branchingCommon()
  {
    console.log( 'branchingCommon' );
  }

  /* - */

}

predeclareMain.timeOut = 60000;

//

function predeclareNpmBasic( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  act({});

  return ready;

  /* - xxx */

  function act( env )
  {

    /* */

//     ready.then( () =>
//     {
//       test.case = `full relative path, ${__.entity.exportStringSolo( env, { level : 1 } )}`;
//
//       var programPath = a.program( mainWithFullPath );
//       a.program
//       ({
//         routine : module1,
//         dirPath : 'node_modules',
//       });
//
//       return a.forkNonThrowing
//       ({
//         execPath : programPath,
//         currentPath : _.path.dir( programPath ),
//       })
//     })
//     .then( ( op ) =>
//     {
//       var exp =
// `
// main
// module1
// `
//       test.identical( op.exitCode, 0 );
//       test.equivalent( op.output, exp );
//       return op;
//     });
//
//     /* */
//
//     ready.then( () =>
//     {
//       test.case = `require name, ${__.entity.exportStringSolo( env, { level : 1 } )}`;
//
//       var programPath = a.program( mainWithRequireName );
//       a.program
//       ({
//         routine : module1,
//         dirPath : 'node_modules',
//       });
//
//       return a.forkNonThrowing
//       ({
//         execPath : programPath,
//         currentPath : _.path.dir( programPath ),
//       })
//     })
//     .then( ( op ) =>
//     {
//       var exp =
// `
// main
// module1
// `
//       test.identical( op.exitCode, 0 );
//       test.equivalent( op.output, exp );
//       return op;
//     });

    /* */

    ready.then( () =>
    {
      test.case = `name, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      var programPath = a.program( mainWithName );
      a.program
      ({
        routine : module1,
        dirPath : 'node_modules',
      });

      return a.forkNonThrowing
      ({
        execPath : programPath,
        currentPath : _.path.dir( programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
`
main
module1
`
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

    /* */

  }

  /* - */

  function mainWithFullPath()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );
    console.log( 'main' );
    _.module.predeclare({ name : 'Mod1', entryPath : __dirname + '/node_modules/module1' } );
    _.include( 'Mod1' );
  }

  /* - */

  function mainWithRequireName()
  {
    console.log( 'main' );
    require( 'module1' );
  }

  /* - */

  function mainWithName()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );
    console.log( 'main' );
    _.module.predeclare({ name : 'Mod1', entryPath : 'module1' } );
    _.include( 'Mod1' );
  }

  /* - */

  function module1()
  {
    console.log( 'module1' );
  }

  /* - */

}

//

function moduleIsIncluded( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  let start = __.process.starter
  ({
    outputCollecting : 1,
    outputPiping : 1,
    inputMirroring : 1,
    throwingExitCode : 0,
    mode : 'fork',
  });

  test.true( _.module.isIncluded( 'wTesting' ) );
  test.true( !_.module.isIncluded( 'abcdef123' ) );

  act({ routine : _programWithRequire });
  // act({ routine : _programWithIncludeLower });
  // act({ routine : _programWithIncludeUpper });
  // xxx : uncomment

  return ready;

  /* - xxx */

  function act( env )
  {

    ready.then( () =>
    {
      test.case = `basic, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      let program = __.program.write
      ({
        routine : env.routine,
        withSubmodules : 1,
        moduleFile : _.module.fileWith( 0 ),
        tempPath : a.abs( '.' ),
      });

      console.log( _.strLinesNumber( program.sourceCode ) );

      return start
      ({
        execPath : program.programPath,
        currentPath : _.path.dir( program.programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
  `
  isIncluded( wTesting ) false
  isIncluded( wTesting ) true
  `
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

  }

  /* - */

  function _programWithRequire()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );
    /*
    console.log( `program1.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program1.paths\n  ${module.paths.join( '\n  ' )}` );
    */
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
    require( 'wTesting' );
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
  }

  /* - */

  function _programWithIncludeLower()
  {
    let _ = require( toolsPath );
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
    _.include( 'wlooker' );
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
  }

  /* - */

  function _programWithIncludeUpper()
  {
    let _ = require( toolsPath );
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
    _.include( 'wlooker' );
    console.log( 'isIncluded( wTesting )', _.module.isIncluded( 'wTesting' ) );
  }

  /* - */

}

//

/* xxx : move the test to introspector */
function programWriteOptionWithSubmodule( test )
{
  let context = this;
  let a = test.assetFor( false );
  let ready = __.take( null );

  let start = __.process.starter
  ({
    outputCollecting : 1,
    outputPiping : 1,
    inputMirroring : 1,
    throwingExitCode : 0,
    mode : 'fork',
  });

  act({});

  return ready;

  /* - xxx */

  function act( env )
  {

    ready.then( () =>
    {
      test.case = `basic, ${__.entity.exportStringSolo( env, { level : 1 } )}`;

      let program = __.program.write
      ({
        routine : env.routine,
        moduleFile : _.module.fileWith( 0 ),
        withSubmodules : 1,
      });

      return start
      ({
        execPath : program.programPath,
        currentPath : _.path.dir( program.programPath ),
      })
    })
    .then( ( op ) =>
    {
      var exp =
  `
  isIncluded( wTesting ) false
  isIncluded( wTesting ) true
  `
      test.identical( op.exitCode, 0 );
      test.equivalent( op.output, exp );
      return op;
    });

  }

  /* - */

  function mainRegisterBefore()
  {
    let _ = require( toolsPath );
    let ModuleFileNative = require( 'module' );
    /*
    console.log( `program1.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program1.paths\n  ${module.paths.join( '\n  ' )}` );
    */
    console.log( 'main / before / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'main / before / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
    require( 'dir/program1' );
    console.log( 'main / after / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'main / after / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
  }

  /* - */

  function program1()
  {
    let _ = wTools;
    console.log( 'program1 / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'program1 / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
    require( '../program2' );
  }

  /* - */

  function program2()
  {
    let _ = wTools;
    console.log( 'program2 / isIncluded( Program1 )', _.module.isIncluded( 'Program1' ) );
    console.log( 'program2 / isIncluded( Program2 )', _.module.isIncluded( 'Program2' ) );
  }

  /* - */

}

//

/* qqq xxx : make test from this */
function localPathAssumption( test )
{
  let context = this;
  let a = test.assetFor( false );

  programWrite( program1 );
  programWrite( program2 );
  programWrite( program3 );

  return a.fork({ execPath : a.abs( 'program1' ) })
  .then( ( op ) =>
  {
    var exp =
`
xxx
`
    test.equivalent( op.output, exp );
    test.identical( op.exitCode, 0 );
    return op;
  });

  /* */

  function programWrite( program )
  {
    var postfix =
    `
    ${program.name}();
    `
    __.fileProvider.fileWrite( a.abs( program.name ), program.toString() + postfix );
  }

  /* */

  function program1()
  {
    module.paths.push( '/pro' );
    console.log( `program1.before.paths\n  ${module.paths.join( '\n  ' )}` );
    require( './program2' );
    console.log( `program1.after.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

  function program2()
  {
    module.paths.push( '/program2/local' );
    console.log( `program2.before.paths\n  ${module.paths.join( '\n  ' )}` );
    require( './program3' );
    console.log( `program2.after.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

  function program3()
  {
    module.paths.push( '/program3/local' );
    console.log( `program3.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

}

localPathAssumption.experimental = 1;

//

/* qqq xxx : make test from this */
function globalPathAssumption( test )
{
  let context = this;
  let a = test.assetFor( false );

  programWrite( program1 );
  programWrite( program2 );
  programWrite( program3 );

  return a.fork({ execPath : a.abs( 'program1' ) })
  .then( ( op ) =>
  {
    var exp =
`
xxx
`
    test.equivalent( op.output, exp );
    test.identical( op.exitCode, 0 );
    return op;
  });

  /* */

  function programWrite( program )
  {
    var postfix =
    `
    ${program.name}();
    `
    __.fileProvider.fileWrite( a.abs( program.name ), program.toString() + postfix );
  }

  /* */

  function program1()
  {
    let ModuleFileNative = require( 'module' );
    ModuleFileNative.globalPaths.push( '/program1/global' );
    module.paths.push( '/program1/local' );
    console.log( `program1.before.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program1.before.paths\n  ${module.paths.join( '\n  ' )}` );

    require( './program2' );

    console.log( `program1.after.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program1.after.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

  function program2()
  {
    let ModuleFileNative = require( 'module' );
    ModuleFileNative.globalPaths.push( '/program2/global' );
    module.paths.push( '/program2/local' );
    console.log( `program2.before.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program2.before.paths\n  ${module.paths.join( '\n  ' )}` );

    require( './program3' );

    console.log( `program2.after.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program2.after.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

  function program3()
  {
    let ModuleFileNative = require( 'module' );
    ModuleFileNative.globalPaths.push( '/program3/global' );
    module.paths.push( '/program3/local' );
    console.log( `program3.globalPaths\n  ${ModuleFileNative.globalPaths.join( '\n  ' )}` );
    console.log( `program3.paths\n  ${module.paths.join( '\n  ' )}` );
  }

  /* */

}

globalPathAssumption.experimental = 1;

// --
// test suite definition
// --

const Proto =
{

  name : 'Tools.Module',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
  },

  tests :
  {

    withIsIncluded,
    withoutIsIncluded,
    moduleExportsUndefined,
    resolve,
    toolsPathGetBasic,
    toolsPathGetTester,

    includedModuleSourcePathValid,
    inheritedModuleFilePaths,
    modulingLogistic,

    predeclareBasic,
    predeclareMain,
    predeclareNpmBasic,

    moduleIsIncluded,
    localPathAssumption,
    globalPathAssumption,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
