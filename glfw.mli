type window

val print_hello : unit -> unit
val glfwInit : unit -> bool
val glfwCreateWindow : int -> int -> string -> window
val glfwMakeContextCurrent : window -> unit
val glfwWindowShouldClose : window -> bool
val glfwPollEvents : unit -> unit
val glfwTerminate : unit -> unit
val glfwSwapBuffers : window -> unit
val printFrameBufferSize : window -> unit


val glClearColor : float -> float -> float -> float -> unit

type shaderType =
    | GL_VERTEX_SHADER
    | GL_FRAGMENT_SHADER

type shader

val glCreateShader: shaderType -> shader
val glShaderSource: shader -> string -> unit
val glCompileShader: shader -> unit
val glDeleteShader: shader -> unit
val glGetShaderIsCompiled: shader -> bool
