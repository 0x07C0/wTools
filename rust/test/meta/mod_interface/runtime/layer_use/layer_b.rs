
/// Private namespace of the module.
mod private
{

  /// layer_b_protected
  pub fn layer_b_protected() -> bool
  {
    true
  }

  /// layer_b_orphan
  pub fn layer_b_orphan() -> bool
  {
    true
  }

  /// layer_b_exposed
  pub fn layer_b_exposed() -> bool
  {
    true
  }

  /// layer_b_prelude
  pub fn layer_b_prelude() -> bool
  {
    true
  }

}

/// Protected namespace of the module.
pub mod protected
{
  #[ doc( inline ) ]
  pub use super::orphan::*;
  #[ doc( inline ) ]
  pub use super::private::layer_b_protected;
}

#[ doc( inline ) ]
pub use protected::*;

/// Orphan namespace of the module.
pub mod orphan
{
  #[ doc( inline ) ]
  pub use super::exposed::*;
  #[ doc( inline ) ]
  pub use super::private::layer_b_orphan;
}

/// Exposed namespace of the module.
pub mod exposed
{
  #[ doc( inline ) ]
  pub use super::prelude::*;
  #[ doc( inline ) ]
  pub use super::private::layer_b_exposed;
}

/// Prelude to use essentials: `use my_module::prelude::*`.
pub mod prelude
{
  #[ doc( inline ) ]
  pub use super::private::layer_b_prelude;
}
