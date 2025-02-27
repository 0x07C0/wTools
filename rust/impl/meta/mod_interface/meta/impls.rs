/// Internal namespace.
pub( crate ) mod private
{
  use crate::*;
  use proc_macro_tools::exposed::*;
  use std::collections::HashMap;

// = use

  // x
  // use private::Type1;
  // use private::{ Type1, Type2 };
  // protected use private::Type1;
  // prelude use private::Type1;

// = ?

  // x
  // protected protected1;
  // orphan orphan1;
  // exposed exposed1;
  // prelude prelude1;
  // prelude { prelude1, prelude2 };

// = macro module

  // x
  // macromod mod1;
  // macromod mod2;
  // macromod { mod1, mod2 };

  // - narrowing

  // x
  // orphan macromod mod_orphan1;
  // : protected -> protected
  // : orphan -> orphan
  // : exposed -> orphan
  // : prelude -> orphan

  // - extending

  // x
  // prelude exposed macromod mod_protected1;
  // : protected -> exposed
  // : orphan -> exposed
  // : exposed -> exposed
  // : prelude -> prelude

  // x
  // prelude protected macromod mod_exposed1;
  // : protected -> protected
  // : orphan -> orphan
  // : exposed -> exposed
  // : prelude -> prelude

  // - selective

  // x
  // exposed exposed macromod mod_exposed1;
  // : protected -> exposed
  // : orphan -> exposed
  // : exposed -> exposed
  // : prelude -> exposed

  // x
  // exposed orphan macromod mod_exposed1;
  // : protected -> orphan
  // : orphan -> orphan
  // : exposed -> exposed
  // : prelude -> exposed

// = micro module

  // x
  // mod mod1;
  // mod mod2;
  // mod { mod1, mod2 };

  // +
  // protected mod mod_protected1;
  // orphan mod mod_orphan1;
  // exposed mod mod_exposed1;
  // prelude mod mod_prelude1;

  // +
  // protected mod { mod_protected1, mod_protected2 };
  // orphan mod { mod_orphan1, mod_orphan2 };
  // exposed mod { mod_exposed1, mod_exposed2 };
  // prelude mod { mod_prelude1, mod_prelude2 };

  ///
  /// Get vector of a clause.
  ///

  macro_rules! clause
  {
    (
      $ClauseMap:ident,
      $( $Key:tt )+
    )
    =>
    {
      $ClauseMap.get_mut( &$( $Key )+() ).unwrap()
    };
  }
  // zzz : clause should not expect the first argument

  ///
  /// Handle record "use" with implicit visibility.
  ///

  fn record_use_implicit
  (
    record : &Record,
    clauses_map : &mut HashMap< u32, Vec< proc_macro2::TokenStream > >,
  )
  ->
  Result< () >
  {

    let attrs1 = &record.attrs;
    let path = record.use_elements.as_ref().unwrap();
    // let vis = record.vis.clone();

    // if vis == Visibility::Inherited

    let _path;
    let path2 = if path.to_add_prefix()
    {
      _path = parse_qt!{ super::private::#path };
      &_path
    }
    else
    {
      path
    };

    // println!( "path2 : {}", qt!{ #path2 } );

    // clauses_map.get_mut( &VisProtected::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisProtected::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      pub use #path2::orphan::*;
    });

    // clauses_map.get_mut( &VisExposed::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisExposed::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      pub use #path2::exposed::*;
    });

    // clauses_map.get_mut( &VisPrelude::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisPrelude::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      pub use #path2::prelude::*;
    });

    Ok( () )
  }

  ///
  /// Handle record "use" with explicit visibility.
  ///

  fn record_use_explicit
  (
    record : &Record,
    clauses_map : &mut HashMap< u32, Vec< proc_macro2::TokenStream > >,
  )
  ->
  Result< () >
  {
    let attrs1 = &record.attrs;
    let path = record.use_elements.as_ref().unwrap();
    let vis = record.vis.clone();

    if !vis.valid_sub_namespace()
    {
      return Err( syn_err!
      (
        record,
        "Use either {} visibility:\n  {}",
        VALID_VISIBILITY_LIST_STR,
        qt!{ #record },
      ));
    }

    let path2 = if path.to_add_prefix()
    {
      qt!{ super::private::#path }
    }
    else
    {
      qt!{ #path }
    };

    let vis2 = if vis.restriction().is_some()
    {
      qt!{ pub( crate ) }
    }
    else
    {
      qt!{ pub }
    };

    // clauses_map.get_mut( &vis.kind() ).unwrap().push( qt!
    clause!( clauses_map, vis.kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      #vis2 use #path2;
    });

    Ok( () )
  }

  ///
  /// Handle record micro module.
  ///

  fn record_micro_module
  (
    record : &Record,
    element : &Pair< AttributesOuter, syn::Path >,
    clauses_map : &mut HashMap< u32, Vec< proc_macro2::TokenStream > >,
  )
  ->
  Result< () >
  {
    let attrs1 = &record.attrs;
    let attrs2 = &element.0;
    let path = &element.1;

    // clauses_map.get_mut( &ClauseImmediates::Kind() ).unwrap().push( qt!
    clause!( clauses_map, ClauseImmediates::Kind ).push( qt!
    {
      #attrs1
      #attrs2
      pub mod #path;
    });

    if !record.vis.valid_sub_namespace()
    {
      return Err( syn_err!
      (
        record,
        "To include a non-standard module use either {} visibility:\n  {}",
        VALID_VISIBILITY_LIST_STR,
        qt!{ #record },
      ));
    }

    // println!( "clauses_map.contains_key( {} ) : {}", record.vis.kind(), clauses_map.contains_key( &record.vis.kind() ) );
    // let fixes_list = clauses_map.get_mut( &record.vis.kind() ).ok_or_else( || syn_err!( "Error!" ) )?;
    // clauses_map.get_mut( &record.vis.kind() ).unwrap().push( qt!
    clause!( clauses_map, record.vis.kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      #attrs2
      pub use super::#path;
    });

    Ok( () )
  }

  ///
  /// Handle record micro module.
  ///

  fn record_layer
  (
    record : &Record,
    element : &Pair< AttributesOuter, syn::Path >,
    clauses_map : &mut HashMap< u32, Vec< proc_macro2::TokenStream > >,
  )
  ->
  Result< () >
  {
    let attrs1 = &record.attrs;
    let attrs2 = &element.0;
    let path = &element.1;

    if record.vis != Visibility::Inherited
    {
      return Err( syn_err!
      (
        record,
        "Layer should not have explicitly defined visibility because all its subnamespaces are used.\n  {}",
        qt!{ #record },
      ));
    }

    // clauses_map.get_mut( &ClauseImmediates::Kind() ).unwrap().push( qt!
    clause!( clauses_map, ClauseImmediates::Kind ).push( qt!
    {
      #attrs1
      #attrs2
      pub mod #path;
    });

    // clauses_map.get_mut( &VisProtected::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisProtected::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      #attrs2
      pub use super::#path::orphan::*;
    });

    // clauses_map.get_mut( &VisExposed::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisExposed::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      #attrs2
      pub use super::#path::exposed::*;
    });

    // clauses_map.get_mut( &VisPrelude::Kind() ).unwrap().push( qt!
    clause!( clauses_map, VisPrelude::Kind ).push( qt!
    {
      #[ doc( inline ) ]
      #attrs1
      #attrs2
      pub use super::#path::prelude::*;
    });

    Ok( () )
  }

  ///
  /// Protocol of modularity unifying interface of a module and introducing layers.
  ///

  pub fn mod_interface( input : proc_macro::TokenStream ) -> Result< proc_macro2::TokenStream >
  {
    use ElementType::*;

    let original_input = input.clone();
    let document = syn::parse::< Thesis >( input )?;
    document.inner_attributes_validate()?;

    // use inspect_type::*;
    // inspect_type_of!( immediates );

    let mut clauses_map : HashMap< _ , Vec< proc_macro2::TokenStream > > = HashMap::new();
    clauses_map.insert( ClauseImmediates::Kind(), Vec::new() );
    //clauses_map.insert( VisPrivate::Kind(), Vec::new() );
    clauses_map.insert( VisProtected::Kind(), Vec::new() );
    clauses_map.insert( VisOrphan::Kind(), Vec::new() );
    clauses_map.insert( VisExposed::Kind(), Vec::new() );
    clauses_map.insert( VisPrelude::Kind(), Vec::new() );

    // zzz : test case with several attrs

    document.records.0.iter().try_for_each( | record |
    {

      match record.element_type
      {
        Use( _ ) =>
        {
          let vis = &record.vis;
          if vis == &Visibility::Inherited
          {
            record_use_implicit( record, &mut clauses_map )?;
          }
          else
          {
            record_use_explicit( record, &mut clauses_map )?;
          }
        },
        _ =>
        {
          record.elements.iter().try_for_each( | element | -> Result::< () >
          {
            match record.element_type
            {
              MicroModule( _ ) =>
              {
                record_micro_module( record, element, &mut clauses_map )?;
              },
              Layer( _ ) =>
              {
                record_layer( record, element, &mut clauses_map )?;
              },
              Use( _ ) =>
              {
              },
            }
            Result::Ok( () )
          })?;
        }
      };

      Result::Ok( () )
    })?;

    let has_debug = document.has_debug();
    let immediates_clause = clauses_map.get( &ClauseImmediates::Kind() ).unwrap();
    let protected_clause = clauses_map.get( &VisProtected::Kind() ).unwrap();
    let orphan_clause = clauses_map.get( &VisOrphan::Kind() ).unwrap();
    let exposed_clause = clauses_map.get( &VisExposed::Kind() ).unwrap();
    let prelude_clause = clauses_map.get( &VisPrelude::Kind() ).unwrap();

    let result = qt!
    {

      #( #immediates_clause )*

      #[ doc( inline ) ]
      pub use protected::*;

      /// Protected namespace of the module.
      pub mod protected
      {
        #[ doc( inline ) ]
        pub use super::orphan::*;
        #( #protected_clause )*
      }

      /// Orphan namespace of the module.
      pub mod orphan
      {
        #[ doc( inline ) ]
        pub use super::exposed::*;
        #( #orphan_clause )*
      }

      /// Exposed namespace of the module.
      pub mod exposed
      {
        #[ doc( inline ) ]
        pub use super::prelude::*;
        #( #exposed_clause )*
      }

      /// Prelude to use essentials: `use my_module::prelude::*`.
      pub mod prelude
      {
        #( #prelude_clause )*
      }

    };

    if has_debug
    {

      // zzz : implement maybe
      // let sections = Sections::new
      // ( vec![
      //   ( "original", original_input ),
      //   ( "result", qt!{ #result } ),
      // ]);
      // println!( "{}", sections );

      println!( "\n = original : \n\n{}\n", original_input );
      println!( "\n = result : \n\n{}\n", qt!{ #result } );
    }

    Ok( result )
  }

}

/// Protected namespace of the module.
pub mod protected
{
  pub use super::orphan::*;
}

pub use protected::*;

/// Parented namespace of the module.
pub mod orphan
{
  pub use super::exposed::*;
}

/// Exposed namespace of the module.
pub mod exposed
{
  pub use super::prelude::*;
  pub use super::private::
  {
  };
}

/// Prelude to use essentials: `use my_module::prelude::*`.
pub mod prelude
{
  pub use super::private::
  {
    mod_interface,
  };
}

// qqq : for Dima : rewrite sample for the module /* aaa : Dmytro : added new samples */
// qqq : for Dima : write description for the module, it should have /* aaa : Dmytro : added */
// - example based on simpified version of test::layer_have_layer with single sublayer
// - example with attribute `#![ debug ]`
