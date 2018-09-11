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

(* GL *)

val glClearColor : float -> float -> float -> float -> unit
val glClearDepth : float -> unit

type shader
type shaderType =
    | GL_VERTEX_SHADER
    | GL_FRAGMENT_SHADER

val glCreateShader: shaderType -> shader
val glShaderSource: shader -> string -> unit
val glCompileShader: shader -> unit
val glDeleteShader: shader -> unit
(*TODO: Remove*)
val glGetShaderIsCompiled: shader -> bool

type enableOptions =
    | GL_DEPTH_TEST

val glEnable: enableOptions -> unit

type depthFunctions =
    | GL_LEQUAL

val glDepthFunc: depthFunctions -> unit

type program

val glCreateProgram: unit -> program
val glAttachShader: program -> shader -> unit
val glLinkProgram: program -> unit
val glUseProgram: program -> unit

type bufferType =
    | GL_ARRAY_BUFFER

type glType =
    | GL_FLOAT

val glVertexAttribPointer: int -> int -> glType -> bool -> unit
val glEnableVertexAttribArray: int -> unit

type buffer
val glCreateBuffer: unit -> buffer
val glBindBuffer: bufferType -> buffer -> unit
val glUnbindBuffer: bufferType -> unit

type vertexArrayObject
val glCreateVertexArray: unit -> vertexArrayObject
val glBindVertexArray: vertexArrayObject -> unit
val glUnbindVertexArray: unit -> unit

type drawType =
    | GL_STATIC_DRAW

val glBufferData: bufferType -> int -> (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t -> drawType -> unit

type drawMode =
    | GL_TRIANGLES

val glDrawArrays: drawMode -> int -> int -> unit

