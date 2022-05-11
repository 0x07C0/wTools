#![ warn( rust_2018_idioms ) ]
#![ warn( missing_debug_implementations ) ]
#![ warn( missing_docs ) ]

//!
//! Collection of general purpose meta tools.
//!

#![ doc = include_str!( concat!( env!( "CARGO_MANIFEST_DIR" ), "/Readme.md" ) ) ]

/// Collection of general purpose meta tools.
pub mod meta;

/// Owned namespace of the module.
pub mod own
{
  pub use super::exposed::*;
  pub use super::meta::parented::*;
}

pub use own::*;

/// Exposed namespace of the module.
pub mod exposed
{
  pub use super::prelude::*;
  pub use super::meta::exposed::*;
}

/// Prelude to use: `use wtools::prelude::*`.
pub mod prelude
{
  pub use super::meta::prelude::*;
}