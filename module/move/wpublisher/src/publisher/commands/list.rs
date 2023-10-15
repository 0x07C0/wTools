/// Internal namespace.
pub( crate ) mod private
{
  use crate::protected::*;
  use std::env;
  use wca::{ Args, Props };
  use wtools::error::BasicError;

  ///
  /// List packages.
  ///

  pub fn list( ( args, _ ) : ( Args, Props ) ) -> Result< (), BasicError >
  {
    let current_path = env::current_dir().unwrap();

    let patterns = args.get_owned::< Vec< String > >( 0 ).unwrap_or_default();
    let paths = files::find( current_path, patterns.as_slice() );
    let paths = paths.iter().filter_map( | s | if s.ends_with( "Cargo.toml" ) { Some( s ) } else { None } );

    for path in paths
    {
      let manifest = manifest_get( path );
      if manifest.package_is()
      {
        let local_is = manifest.local_is();
        let remote = if local_is { "local" } else { "remote" };
        let data = manifest.manifest_data.as_ref().unwrap();
        println!( "{} - {:?}, {}", data[ "package" ][ "name" ].to_string().trim(), path.parent().unwrap(), remote );
      }
    }

    Ok( () )
  }

  //

  fn manifest_get( path : &std::path::Path ) -> manifest::Manifest
  {
    let mut manifest = manifest::Manifest::new();
    manifest.manifest_path_from_str( path ).unwrap();
    manifest.load().unwrap();
    manifest
  }
}

//

crate::mod_interface!
{
  prelude use list;
}