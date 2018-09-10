external print_hello: unit -> unit = "caml_print_hello"

type window

(* GLFW *)
external glfwInit: unit -> bool = "caml_glfwInit"
external glfwCreateWindow: int -> int -> string -> window = "caml_glfwCreateWindow"
external glfwMakeContextCurrent: window -> unit = "caml_glfwMakeContextCurrent"
external glfwWindowShouldClose: window -> bool = "caml_glfwWindowShouldClose"
external glfwPollEvents: unit -> unit = "caml_glfwPollEvents"
external glfwTerminate: unit -> unit = "caml_glfwTerminate"
external glfwSwapBuffers: window -> unit = "caml_glfwSwapBuffers"

(* GL *)
external glClear: unit -> unit = "caml_glClear"

external printFrameBufferSize: window -> unit = "caml_printFrameBufferSize"
