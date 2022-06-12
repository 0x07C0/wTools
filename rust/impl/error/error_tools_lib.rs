#![ cfg_attr( not( feature = "use_std" ), no_std ) ]
#![ doc( html_logo_url = "https://raw.githubusercontent.com/Wandalen/wTools/master/asset/img/logo_v3_trans_square.png" ) ]
#![ doc( html_favicon_url = "https://raw.githubusercontent.com/Wandalen/wTools/alpha/asset/img/logo_v3_trans_square_icon_small_v2.ico" ) ]
#![ doc( html_root_url = "https://docs.rs/error_tools/latest/error_tools/" ) ]
#![ warn( rust_2018_idioms ) ]
#![ warn( missing_debug_implementations ) ]
#![ warn( missing_docs ) ]

//!
//! Basic exceptions handling mechanism.
//!

#![ doc = include_str!( concat!( env!( "CARGO_MANIFEST_DIR" ), "/Readme.md" ) ) ]

/// Assertions.
pub mod assert;
#[ cfg( feature = "use_std" ) ]
/// Default error object.
pub mod error;

/// Dependencies.
pub mod dependencies
{

  #[ doc( inline ) ]
  #[ cfg( feature = "error_handling_for_lib" ) ]
  pub use ::thiserror;

  #[ doc( inline ) ]
  #[ cfg( feature = "error_handling_for_app" ) ]
  pub use ::anyhow;

}

/// Exceptions handling mechanism for libs.
pub mod for_lib
{
  #[ doc( inline ) ]
  #[ cfg( feature = "error_handling_for_lib" ) ]
  pub use ::thiserror::*;
}

/// Exceptions handling mechanism for apps.
pub mod for_app
{
  #[ doc( inline ) ]
  #[ cfg( feature = "error_handling_for_app" ) ]
  pub use ::anyhow::*;
}

/// Protected namespace of the module.
pub mod protected
{
  #[ doc( inline ) ]
  pub use super::orphan::*;
}

#[ doc( inline ) ]
pub use protected::*;
// pub use protected::BasicError;
// #[ cfg( feature = "use_std" ) ]
// #[ doc( inline ) ]
// pub use protected::Error;

/// Shared with parent namespace of the module
pub mod orphan
{
  #[ doc( inline ) ]
  pub use super::exposed::*;
}

/// Exposed namespace of the module.
pub mod exposed
{
  #[ doc( inline ) ]
  pub use super::prelude::*;
  #[ doc( inline ) ]
  pub use super::assert::*;

  #[ cfg( feature = "use_std" ) ]
  #[ doc( inline ) ]
  pub use super::error::*;
  // #[ cfg( feature = "use_std" ) ]
  // #[ doc( inline ) ]
  // pub use super::error::Error;

}

/// Prelude to use essentials: `use my_module::prelude::*`.
pub mod prelude
{
}
