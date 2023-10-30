/// Internal namespace.
pub( crate ) mod private
{
  use macro_tools::prelude::*;
  use macro_tools::Result;

  #[ derive( Debug, PartialEq, Eq, Clone ) ]
  pub struct UseTree
  {
    pub leading_colon : Option< syn::token::Colon2 >,
    pub tree : syn::UseTree,
  }

  impl UseTree
  {

    /// Is adding prefix to the tree path required?
    pub fn to_add_prefix( &self ) -> bool
    {
      use syn::UseTree::*;
      if self.leading_colon.is_some()
      {
        return false;
      }
      match &self.tree
      {
        Path( e ) => e.ident != "super" && e.ident != "crate",
        Rename( e ) => e.ident != "super" && e.ident != "crate",
        _ => true,
      }
    }

  }

  impl syn::parse::Parse for UseTree
  {
    fn parse( input : ParseStream< '_ > ) -> Result< Self >
    {
      Ok( Self
      {
        leading_colon : input.parse()?,
        tree : input.parse()?,
      })
    }
  }

  impl quote::ToTokens for UseTree
  {
    fn to_tokens( &self, tokens : &mut proc_macro2::TokenStream )
    {
      self.leading_colon.to_tokens( tokens );
      self.tree.to_tokens( tokens );
    }
  }

}

#[ allow( unused_imports ) ]
pub use protected::*;

/// Protected namespace of the module.
pub mod protected
{
  #[ allow( unused_imports ) ]
  pub use super::orphan::*;
}

/// Parented namespace of the module.
pub mod orphan
{
  #[ allow( unused_imports ) ]
  pub use super::exposed::*;
}

/// Exposed namespace of the module.
pub mod exposed
{
  #[ allow( unused_imports ) ]
  pub use super::prelude::*;

  #[ allow( unused_imports ) ]
  pub use super::private::
  {
    UseTree,
  };

}

/// Prelude to use essentials: `use my_module::prelude::*`.
pub mod prelude
{
}