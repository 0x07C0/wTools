#![ warn( rust_2018_idioms ) ]
#![ deny( missing_debug_implementations ) ]
#![ deny( missing_docs ) ]

// #![ feature( trace_macros ) ]

#[ allow( unused_imports ) ]
use data_type as TheModule;
#[ allow( unused_imports ) ]
use test_tools::exposed::*;

#[ path = "./inc.rs" ]
mod inc;
