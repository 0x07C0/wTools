/// Internal namespace.
mod private
{
  use std::path::PathBuf;
  use crate::{ endpoint, wtools };

  use crate::tools::bool::*;
  use wca::{ Args, Props };
  use wtools::error::Result;
  use anyhow::*;

  ///
  /// Publish package.
  ///

  pub fn publish( ( args, properties ) : ( Args, Props ) ) -> Result< () >
  {
    let patterns : Vec< _ > = args.get_owned( 0 ).unwrap_or_else( || vec![ "./".into() ] );
    let dry : bool = properties.get_owned( "dry" ).map( | dry : String | dry.to_bool_like() ).unwrap_or_else( || BoolLike::True ).into();

    println!( "`publish` command patterns: {patterns:?}, dry: {dry}" );
    match endpoint::publish( patterns, dry )
    {
      core::result::Result::Ok( report ) =>
      {
        println!( "{report}" );

        Ok( () )
      }
      Err(( report, e )) =>
      {
        eprintln!( "{report}" );

        Err( e.context( "publish command" ) )
      }
    }
  }

  ///
  /// Publish packages from workspace.
  ///

  pub fn workspace_publish( ( args, properties ) : ( Args, Props ) ) -> Result< () >
  {
    let path_to_workspace : PathBuf = args.get_owned( 0 ).unwrap_or( std::env::current_dir().context( "Workspace publish command without subject" )? );
    let dry = properties.get_owned( "dry" ).map( | dry : String | dry.to_bool_like() ).unwrap_or_else( || BoolLike::True ).into();

    match endpoint::workspace_publish( path_to_workspace, dry )
    {
      core::result::Result::Ok( report ) =>
      {
        println!( "{report}" );

        Ok( () )
      }
      Err(( report, e )) =>
      {
        eprintln!( "{report}" );

        Err( e.context( "workspace publish command" ) )
      }
    }
  }
}

//

crate::mod_interface!
{
  /// List packages.
  prelude use publish;
  /// List workspace packages.
  prelude use workspace_publish;
}