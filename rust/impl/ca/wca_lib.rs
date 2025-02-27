#![ cfg_attr( not( feature = "use_std" ), no_std ) ]
#![ doc( html_logo_url = "https://raw.githubusercontent.com/Wandalen/wTools/master/asset/img/logo_v3_trans_square.png" ) ]
#![ doc( html_favicon_url = "https://raw.githubusercontent.com/Wandalen/wTools/alpha/asset/img/logo_v3_trans_square_icon_small_v2.ico" ) ]
#![ doc( html_root_url = "https://docs.rs/wca/latest/wca/" ) ]
#![ deny( rust_2021_compatibility ) ]
#![ deny( missing_debug_implementations ) ]
#![ deny( missing_docs ) ]

//!
//! The tool to make CLI ( commands user interface ). It is able to aggregate external binary applications, as well as functions, which are written in your language.
//!
//!

#![ doc = include_str!( concat!( env!( "CARGO_MANIFEST_DIR" ), "/../../../", "doc/modules/wca/", "wca.md" ) ) ]

// #![ doc = include_str!( concat!( env!( "CARGO_MANIFEST_DIR" ), "/", "Readme.md" ) ) ]

#![ allow( where_clauses_object_safety ) ] // https://github.com/chris-morgan/anymap/issues/31

/// Requests parser.
#[ cfg( feature = "use_std" ) ]
pub mod string
{
  pub use wtools::string::*;
}

/// Errors.
#[ cfg( feature = "use_std" ) ]
pub use wtools::{ Result, BasicError, err };
// xxx : check

use wtools::meta::mod_interface;

crate::mod_interface!
{
  /// Commands aggregator library.
  #[ cfg( feature = "use_std" ) ]
  layer ca;

  // protected( crate ) use super::
  // {
  //   field_str,
  //   field_map_str_str,
  //   field_map_str_vec_str,
  //   field_routine,
  // };

}

// xxx : qqq : rid off. use mod_interface
// #[ cfg( feature = "use_std" ) ]
// #[ doc( inline ) ]
// pub use ca::
// {
//   input,
//   parser,
//   grammar,
//   executor,
//   commands_aggregator,
//   adapter,
// };
