open EsyGlfwExamples;

open Js_of_ocaml;

try%lwt (Basic.run()) {
| Js.Error(s) => Lwt.return(print_endline("ERROR: " ++ Js.string_of_error(s)));
| _  => Lwt.return(print_endline("Unknown error"));
}
