pub( crate ) mod private
{
  use wtools::{ Result, err };

  /// Available types that can be converted to a `Value`
  /// 
  /// Uses for configure subjects and properties types to validate it after parsing.
  ///
  /// ```
  /// # use wca::{ Type, Value, TryCast };
  /// # fn main() -> Result< (), Box< dyn std::error::Error > > {
  /// let raw_value = "3".to_string();
  /// let kind = Type::Number;
  /// 
  /// let value = kind.try_cast( raw_value )?;
  /// assert_eq!( Value::Number( 3.0 ), value );
  /// # Ok( () ) }
  /// ```
  /// 
  /// In the above example, the `Type` enum is used to represent the expected type of the value for a property. The `Number` type is chosen, and the raw value is parsed and validated to ensure it matches this type.
  /// 
  #[ derive( Debug, Clone, PartialEq, Eq ) ]
  pub enum Type
  {
    /// String
    String,
    /// Number
    Number,
    /// Path
    Path,
    /// List of some type values separated a delimiter character
    List( Box< Type >, char ),
  }

  /// Can be implemented for something that represents a type of value
  pub trait TryCast< T >
  {
    /// return casted value
    fn try_cast( &self, value : String ) -> Result< T >;
  }

  /// Container for a `Value` of a specific type
  /// 
  /// Uses for represent of subjects and properties in Commands( E.g. `GrammarCommand`, `ExecutableCommand` )
  /// With `wca::Type` enum and `TryCast` you can cast raw string into specific Type.
  /// You can also convert to a type that can be converted from the internal Value type.
  /// 
  /// # Example:
  /// 
  /// ```
  /// # use wca::{ GrammarCommand, Value };
  /// # use wtools::HashMap;
  /// let command = GrammarCommand
  /// {
  ///   phrase : "command".to_string(),
  ///   // Here is numeric value used
  ///   subjects : vec![ Value::Number( 3.14 ) ],
  ///   properties : HashMap::from_iter(
  ///   [
  ///     // Here is string value used
  ///     ( "string_prop".to_string(), Value::String( "value".to_string() ) ),
  ///   ])
  /// };
  /// 
  /// let number : f32 = command.subjects[ 0 ].clone().into();
  /// assert_eq!( 3.14, number );
  /// 
  /// let number : i32 = command.subjects[ 0 ].clone().into();
  /// assert_eq!( 3, number );
  /// ```
  #[ derive( Debug, Clone, PartialEq ) ]
  pub enum Value
  {
    /// String value
    String( String ),
    /// Number value(float number but can be casted to another types)
    Number( f64 ),
    /// Path
    Path( std::path::PathBuf ),
    /// List
    List( Vec< Value > ),
  }

  macro_rules! value_into_impl
  {
    ( $( $value_kind : path => $( $kind : ty => $cast : expr ),+ );+ ) =>
    {
      $( $(
        impl From< Value > for $kind
        {
          fn from( value : Value ) -> Self
          {
            match value
            {
              #[ allow( clippy::redundant_closure_call ) ]// ok because of it improve understanding what is `value` at macro call
              $value_kind( value ) => ( $cast )( value ),
              _ => panic!( "Unknown cast variant. Got `{value:?}` and try to cast to `{}`", stringify!( $kind ) )
            }
          }
        }
      )+ )+
    };
  }

  // makes from Value variant an native value
  value_into_impl!
  {
    Value::Number =>
      u32 => | value | value as u32,
      u64 => | value | value as u64,
      i32 => | value | value as i32,
      i64 => | value | value as i64,
      f32 => | value | value as f32,
      f64 => | value | value;
    Value::String =>
      String => String::from,
      &'static str => | value : String | Box::leak( value.into_boxed_str() );
    Value::Path =>
      std::path::PathBuf => | value | value
  }

  impl< T : From< Value > > From< Value > for Vec< T >
  {
    fn from( value : Value ) -> Self
    {
      match value
      {
        Value::List( value ) => value.into_iter().map( | x | x.into() ).collect(),
        _ => panic!( "Unknown cast variant. Got `{value:?}` and try to cast to `Vec<{}>`", std::any::type_name::< T >() )
      }
    }
  }

  impl TryCast< Value > for Type
  {
    fn try_cast( &self, value : String ) -> Result< Value >
    {
      match self
      {
        Self::String => Ok( Value::String( value ) ),
        Self::Number => value.parse().map_err( | _ | err!( "Can not parse number from `{}`", value ) ).map( Value::Number ),
        Self::Path => Ok( Value::Path( value.into() ) ),
        Self::List( kind, delimeter ) =>
        {
          let values = value
          .split( *delimeter )
          .map( | val | kind.try_cast( val.into() ) )
          .collect::< Result< Vec< Value > > >()?;
          Ok( Value::List( values ) )
        },
      }
    }
  }
}

//

crate::mod_interface!
{
  prelude use Type;
  prelude use Value;
  prelude use TryCast;
}
