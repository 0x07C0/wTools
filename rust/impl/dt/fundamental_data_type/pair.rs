/// Internal namespace.
mod internal
{
  use crate::exposed::*;

  ///
  /// Macro to declare another type wrapping a pair another type into a tuple.
  ///
  /// Auto-implement traits From, Into and Dereference for the wrapper.
  ///

  #[ macro_export ]
  macro_rules! pair
  {

    (
      $( #[ $Meta : meta ] )*
      $Name : ident :
      < $( $ParamName : ident $( : $ParamTy1x1 : ident $( :: $ParamTy1xN : ident )* $( + $ParamTy2 : path )* )? )* >
      $(;)?
    )
    =>
    {
      $( #[ $Meta ] )*
      pub struct $Name
      < $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* >
      ( pub $( $ParamName )* );

      impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > core::ops::Deref
      for $Name
      < $( $ParamName )* >
      {
        type Target = $( $ParamName )*;
        fn deref( &self ) -> &Self::Target
        {
          &self.0
        }
      }

      impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > From< $( $ParamName )* >
      for $Name
      < $( $ParamName )* >
      {
        fn from( src : $( $ParamName )* ) -> Self
        {
          Self( src )
        }
      }

      // impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > From< $Name< $( $ParamName )* > >
      // for $( $ParamName )*
      // {
      //   fn from( src : $Name< $( $ParamName )* > ) -> Self
      //   {
      //     src.0
      //   }
      // }

    };

    (
      $( #[ $Meta : meta ] )*
      $Name : ident : $TypeSplit1 : ident $( :: $TypeSplitN : ident )*
      < $( $ParamName : ident $( : $ParamTy1x1 : ident $( :: $ParamTy1xN : ident )* $( + $ParamTy2 : path )* )? )* >
      $(;)?
    )
    =>
    {
      $( #[ $Meta ] )*
      pub struct $Name
      < $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* >
      ( pub $TypeSplit1 $( :: $TypeSplitN )* < $( $ParamName )* > );

      impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > core::ops::Deref
      for $Name
      < $( $ParamName )* >
      {
        type Target = $TypeSplit1 $( :: $TypeSplitN )* < $( $ParamName )* >;
        fn deref( &self ) -> &Self::Target
        {
          &self.0
        }
      }

      impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > From< $TypeSplit1 $( :: $TypeSplitN )* < $( $ParamName )* > >
      for $Name
      < $( $ParamName )* >
      {
        fn from( src : $TypeSplit1 $( :: $TypeSplitN )* < $( $ParamName )* > ) -> Self
        {
          Self( src )
        }
      }

      impl< $( $ParamName $( : $ParamTy1x1 $( :: $ParamTy1xN )* $( + $ParamTy2 )* )? )* > From< $Name< $( $ParamName )* > >
      for $TypeSplit1 $( :: $TypeSplitN )* < $( $ParamName )* >
      {
        fn from( src : $Name< $( $ParamName )* > ) -> Self
        {
          src.0
        }
      }

    };

    (
      $( #[ $Meta : meta ] )*
      $Name : ident : $TypeSplit1 : ident $( :: $TypeSplitN : ident )* $(;)?
      // $Name : ident : $Type : ty $(;)?
    )
    =>
    {
      $crate::pair!
      (
        $( #[ $Meta ] )*
        $Name : $TypeSplit1 $( :: $TypeSplitN )* <>;
      );

    };

  }

//   pair!
//   {
//
//     ///
//     /// A type wrapping a pair another type into a tuple.
//     ///
//
//     #[ derive( Debug, Clone, PartialEq, Eq ) ]
//     Pair : < T1, T2 >;
//
//   }

  pub use pair;
}

/// Protected namespace of the module.
pub mod protected
{
  pub use super::orphan::*;
}

pub use protected::*;

/// Orphan namespace of the module.
pub mod orphan
{
  pub use super::exposed::*;
}

/// Exposed namespace of the module.
pub mod exposed
{
  pub use super::prelude::*;
}

pub use exposed::*;

/// Prelude to use: `use wtools::prelude::*`.
pub mod prelude
{
  pub use super::internal::
  {
    pair,
    // Pair,
  };
}