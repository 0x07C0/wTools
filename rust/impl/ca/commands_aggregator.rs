
pub( crate ) mod private
{
  use crate::command::*;
  use crate::instruction::*;
  use wtools::meta::*;
  use wtools::error::*;
  use wtools::former::Former;

  ///
  /// Commands aggregator.
  ///

  /*
     Dmytro : owned types are used because Former does not work with combination of links and
     containers
   */

  #[ derive( Debug, PartialEq ) ]
  #[ derive( Former ) ]
  #[ allow( missing_docs ) ]
  pub struct CommandsAggregator
  {
    pub base_path : Option<std::path::PathBuf>,
    #[ default( "".to_string() ) ]
    pub command_prefix : String,
    #[ default( vec![ ".".to_string(), " ".to_string() ] ) ]
    pub delimeter : Vec< String >,
    #[ default( ";".to_string() ) ]
    pub command_explicit_delimeter : String,
    #[ default( " ".to_string() ) ]
    pub command_implicit_delimeter : String,
    #[ default( true ) ]
    pub commands_explicit_delimiting : bool,
    #[ default( false ) ]
    pub commands_implicit_delimiting : bool,
    #[ default( false ) ]
    pub properties_map_parsing : bool,
    #[ default( true ) ]
    pub several_values : bool,
    #[ default( true ) ]
    pub with_help : bool,
    #[ default( true ) ]
    pub changing_exit_code : bool,
    // logger : Option<Logger>, /* qqq : implement */
    pub commands : std::collections::HashMap< String, Command >,
    // pub vocabulary : Option<vocabulary>, /* qqq : implement */
  }

  impl CommandsAggregator
  {
    /// Perform instructions queue as single program.
    pub fn program_perform( &self, _program : &str ) -> Result< (), BasicError >
    {
      unimplemented!( "not implemented" );
      // let parsed = program_parse( program );
    }

    /// Perform instruction.
    pub fn instruction_perform( &self, instruction : impl AsRef< str > ) -> Result< (), BasicError >
    {
      let parsed : Instruction = instruction_parse()
      .instruction( instruction.as_ref() )
      .several_values( self.several_values )
      .properties_map_parsing( self.properties_map_parsing )
      .quoting( true )
      .unquoting( true )
      .perform();

      let result = match self.command_resolve( &parsed )
      {
        Some( command ) =>
        {
          command.perform( &parsed )
        },
        None =>
        {
          if self.with_help
          {
            self.on_get_help().unwrap();
          }
          if self.changing_exit_code
          {
            std::process::exit( 1 );
          }
          Ok( () )
        },
      };

      result
    }

    /// Print help for command.
    fn command_help( &self, command : impl AsRef< str > )
    {
      /* qqq : command should print help, not CA */
      if command.as_ref() == ""
      {
        for ( command_name, command_descriptor ) in self.commands.iter()
        {
          println!( "{} - {}", command_name, command_descriptor.hint );
        }
      }
      else
      {
        if let Some( command_descriptor ) = self.commands.get( command.as_ref() )
        {
          println!( "{} - {}", command.as_ref(), command_descriptor.hint );
        }
      }
    }

    /// Find command in dictionary.
    fn command_resolve( &self, instruction : &Instruction ) -> Option<&Command>
    {
      self.commands.get( &instruction.command_name )
    }
  }

  //

  ///
  /// On error helper.
  ///

  pub trait OnError
  {
    /// Handle error.
    fn on_error( &self, err : BasicError ) -> Result< (), BasicError >;
  }

  ///
  /// On syntax error helper.
  ///

  pub trait OnSyntaxError
  {
    /// Handle syntax error.
    fn on_syntax_error( &self, command : impl AsRef< str > ) -> Result< (), BasicError >;
  }

  ///
  /// On ambiguity helper.
  ///

  pub trait OnAmbiguity
  {
    /// Handle ambiguity.
    fn on_ambiguity( &self, command : impl AsRef< str > ) -> Result< (), BasicError >;
  }

  ///
  /// On unknown command error helper.
  ///

  pub trait OnUnknownCommandError
  {
    /// Handle unknown command error.
    fn on_unknown_command_error( &self, command : impl AsRef< str > ) -> Result< (), BasicError >;
  }

  ///
  /// Help helper.
  ///

  pub trait OnGetHelp
  {
    /// Get help.
    fn on_get_help( &self ) -> Result< (), BasicError >;
  }

  ///
  /// Printing commands helper.
  ///

  pub trait OnPrintCommands
  {
    /// Print all commands.
    fn on_print_commands( &self ) -> Result< (), BasicError >;
  }

  ///
  /// Super trait that checks that all helpers are implemented.
  ///

  pub trait CommandsAggregatorHandlers : OnError + OnSyntaxError + OnAmbiguity + OnUnknownCommandError + OnGetHelp + OnPrintCommands
  {
  }

  impl CommandsAggregatorHandlers for CommandsAggregator {}

  #[ cfg( feature = "on_error_default" ) ]
  impl OnError for CommandsAggregator
  {
    /// Handle error.
    fn on_error( &self, err : BasicError ) -> Result< (), BasicError >
    {
      if self.changing_exit_code
      {
        unimplemented!();
      }
      Err( err )
    }
  }

  #[ cfg( feature = "on_syntax_error_default" ) ]
  impl OnSyntaxError for CommandsAggregator
  {
    /// Handle syntax error.
    fn on_syntax_error( &self, command : impl AsRef< str > ) -> Result< (), BasicError >
    {
      let err_formatted = format!( "Illformed command \"{}\"", command.as_ref() );
      eprintln!( "{}", err_formatted );
      self.on_get_help().unwrap();

      let err = BasicError::new( err_formatted );
      return self.on_error( err );
    }
  }

  #[ cfg( feature = "on_ambiguity_default" ) ]
  impl OnAmbiguity for CommandsAggregator
  {
    /// Handle ambiguity.
    fn on_ambiguity( &self, command : impl AsRef< str > ) -> Result< (), BasicError >
    {
      eprintln!( "Ambiguity. Did you mean?" );
      self.command_help( command.as_ref() );
      println!( "" );

      let err_formatted = format!( "Ambiguity \"{}\"", command.as_ref() );
      let err = BasicError::new( err_formatted );
      return self.on_error( err );
    }
  }

  #[ cfg( feature = "on_unknown_command_error_default" ) ]
  impl OnUnknownCommandError for CommandsAggregator
  {
    /// Handle unknown command error.
    fn on_unknown_command_error( &self, command : impl AsRef< str > ) -> Result< (), BasicError >
    {
      let mut err_formatted = format!( "Unknown command \"{}\"", command.as_ref() );

      let instruction = instruction_parse()
      .instruction( ".help" )
      .perform();
      if self.command_resolve( &instruction ).is_some()
      {
        err_formatted.push_str( "\nTry \".help\"" );
      }
      let err = BasicError::new( err_formatted );
      return self.on_error( err );
    }
  }

  #[ cfg( feature = "on_get_help_default" ) ]
  impl OnGetHelp for CommandsAggregator
  {
    /// Get help.
    fn on_get_help( &self ) -> Result< (), BasicError >
    {
      let instruction = instruction_parse()
      .instruction( ".help" )
      .perform();
      if let Some( command ) = self.command_resolve( &instruction )
      {
        let instruction = instruction_parse()
        .instruction( "" )
        .perform();
        return command.perform( &instruction );
      }
      else
      {
        self.command_help( "" );
        return Ok( () );
      }
    }
  }

  #[ cfg( feature = "on_print_commands_default" ) ]
  impl OnPrintCommands for CommandsAggregator
  {
    /// Print all commands.
    fn on_print_commands( &self ) -> Result< (), BasicError >
    {
      println!( "" );
      self.command_help( "" );
      println!( "" );
      Ok( () )
    }
  }

  //

  ///
  /// Get instruction parser builder.
  ///

  pub fn commands_aggregator() -> CommandsAggregatorFormer
  {
    CommandsAggregator::former()
  }

}

/// Protected namespace of the module.
pub mod protected
{
  pub use super::private::CommandsAggregator;
  pub use super::private::commands_aggregator;
}

pub use protected::*;

/// Exposed namespace of the module.
pub mod exposed
{
  pub use super::prelude::*;
}

/// Namespace of the module to include with `use module::*`.
pub mod prelude
{
  pub use super::private::CommandsAggregator;
  pub use super::private::commands_aggregator;
}

