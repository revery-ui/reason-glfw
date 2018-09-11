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
type shader
type shaderType =
    | GL_VERTEX_SHADER
    | GL_FRAGMENT_SHADER

external glClearColor: float -> float -> float -> float -> unit = "caml_glClearColor"
external glCreateShader: shaderType -> shader = "caml_glCreateShader"
external glShaderSource: shader -> string -> unit = "caml_glShaderSource"
external glCompileShader: shader -> unit = "caml_glCompileShader"
external glDeleteShader: shader -> unit = "caml_glDeleteShader"
external glGetShaderIsCompiled: shader -> bool = "caml_glGetShaderIsCompiled"

external printFrameBufferSize: window -> unit = "caml_printFrameBufferSize"
