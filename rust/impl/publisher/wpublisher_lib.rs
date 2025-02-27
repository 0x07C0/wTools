#![ cfg_attr( not( feature = "use_std" ), no_std ) ]
#![ doc( html_logo_url = "https://raw.githubusercontent.com/Wandalen/wTools/master/asset/img/logo_v3_trans_square.png" ) ]
#![ doc( html_favicon_url = "https://raw.githubusercontent.com/Wandalen/wTools/alpha/asset/img/logo_v3_trans_square_icon_small_v2.ico" ) ]
#![ doc( html_root_url = "https://docs.rs/wpublisher/" ) ]
#![ warn( rust_2018_idioms ) ]
#![ deny( missing_debug_implementations ) ]
#![ deny( missing_docs ) ]

//!
//! Utility to publish modules on `crates.io` from a command line.
//!

#![ doc = include_str!( concat!( env!( "CARGO_MANIFEST_DIR" ), "/", "Readme.md" ) ) ]

// qqq : for Dima : that should be in mod_interface /* aaa : Dmytro : moved to the macro */
// #[ cfg( feature = "use_std" ) ]
// pub use std::env;
// #[ allow( unused_imports ) ]
// pub use wca::instruction;

wtools::mod_interface!
{
  /// Library of utility to operate packages from a command line.
  #[ cfg( feature = "use_std" ) ]
  layer tools; // qqq : for Dima : bad name of a namespace /* aaa : Dmytro : renamed */
  /// Library of utility to work with commands.
  #[ cfg( feature = "use_std" ) ]
  layer commands;

  #[ cfg( feature = "use_std" ) ]
  prelude use ::std::env;
  // prelude use ::wca::*;
  protected( crate ) use ::wtools::prelude::*;
}
