
#[ allow( unused_imports ) ]
use quote::{ quote };
#[ allow( unused_imports ) ]
use syn::{ parse_quote };
#[ allow( unused_imports ) ]
use proc_macro_tools::prelude::*;
#[ allow( unused_imports ) ]
// use proc_macro_tools::{ Result, Items };
use proc_macro_tools::{ Result, Many, syn };

///
/// Module-specific item.
///

#[ derive( Debug ) ]
pub struct Item2
{
  pub optional : Option< Token![ ? ] >,
  pub func : syn::Item,
}

impl AsMuchAsPossibleNoDelimiter for Item2 {}
// xxx : qqq : introduce trait

//

impl syn::parse::Parse for Item2
{
  fn parse( input : syn::parse::ParseStream< '_ > ) -> Result< Self >
  {
    let optional = input.parse()?;
    let func = input.parse()?;
    Ok( Self{ optional, func } )
  }
}

//

impl quote::ToTokens for Item2
{
  fn to_tokens( &self, tokens : &mut proc_macro2::TokenStream )
  {
    self.optional.to_tokens( tokens );
    self.func.to_tokens( tokens );
  }
}

//

#[ derive( Debug ) ]
pub struct Items2
(
  pub Many< Item2 >,
);

//

impl syn::parse::Parse for Items2
{
  fn parse( input : syn::parse::ParseStream< '_ > ) -> Result< Self >
  {
    let many = input.parse()?;
    Ok( Self( many ) )
  }
}

//

impl quote::ToTokens for Items2
{
  fn to_tokens( &self, tokens : &mut proc_macro2::TokenStream )
  {
    self.0.iter().for_each( | e |
    {
      let func = &e.func;

      let declare_aliased = quote!
      {
        ( as $Name2 : ident ) =>
        {
          ::impls_index::fn_rename!
          {
            @Name { $Name2 }
            @Fn
            {
              #func
            }
          }
        };
      };

      let mut mandatory = quote!
      {
        #[ allow( unused_macros ) ]
      };

      if e.optional.is_none()
      {
        mandatory = quote!
        {
          #[ deny( unused_macros ) ]
        }
      }

      let name_str = func.name();
      let name_ident = syn::Ident::new( &name_str[ .. ], proc_macro2::Span::call_site() );
      let result = quote!
      {
        #mandatory
        macro_rules! #name_ident
        {
          #declare_aliased
          () =>
          {
            #func
          };
        }
      };
      // tree_print!( result );
      result.to_tokens( tokens )
    });
  }
}

//

pub fn impls( input : proc_macro::TokenStream ) -> Result< proc_macro2::TokenStream >
{
  let items2 = syn::parse::< Items2 >( input )?;

  let result = quote!
  {
    #items2
  };

  Ok( result )
}
