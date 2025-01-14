/// Internal namespace.
pub( crate ) mod private
{
  pub use std::error::Error as ErrorInterface;

  ///
  /// Macro to generate error.
  ///
  /// ### Sample
  /// ```
  /// # use error_tools::*;
  /// err!( "No attr" );
  /// ```
  ///

  #[ macro_export ]
  macro_rules! err
  {

    ( $msg : expr ) =>
    {
      $crate::BasicError::new( $msg )
    };
    ( $msg : expr, $( $arg : expr ),+ ) =>
    {
      $crate::BasicError::new( format!( $msg, $( $arg ),+ ) )
    };

  }

  /// baic implementation of generic BasicError

  #[ derive( core::fmt::Debug, core::clone::Clone, core::cmp::PartialEq, core::cmp::Eq ) ]
  pub struct BasicError
  {
    msg : String,
  }

  impl BasicError
  {
    /// Constructor expecting message with description.
    pub fn new< Msg : Into< String > >( msg : Msg ) -> BasicError
    {
      BasicError { msg : msg.into() }
    }
    /// Message with description getter.
    pub fn msg( &self ) -> &String
    {
      &self.msg
    }
  }

  impl core::fmt::Display for BasicError
  {
    fn fmt(&self, f: &mut core::fmt::Formatter< '_ >) -> core::fmt::Result
    {
      write!( f, "{}", self.msg )
    }
  }

  impl ErrorInterface for BasicError
  {
    fn description( &self ) -> &str
    {
      &self.msg
    }
  }

  pub use err;

  // qqq : write standard mod interface without using mod_interface /* aaa : Dmytro : added to each library file */
}

/// Protected namespace of the module.
pub mod protected
{
  #[ doc( inline ) ]
  pub use super::orphan::*;
}

#[ doc( inline ) ]
pub use protected::*;

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
}

/// Prelude to use essentials: `use my_module::prelude::*`.
pub mod prelude
{
  pub use super::private::err;
  pub use super::private::ErrorInterface;
  pub use super::private::BasicError;
}
