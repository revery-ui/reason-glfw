external print_hello: unit -> unit = "caml_print_hello"

type window


external glfwInit: unit -> bool = "caml_glfwInit"
external glfwCreateWindow: unit -> window = "caml_glfwCreateWindow"
external glfwMakeContextCurrent: window -> unit = "caml_glfwMakeContextCurrent"

external printFrameBufferSize: window -> unit = "caml_printFrameBufferSize"

let () =
    print_hello ();
    glfwInit();
    let w = glfwCreateWindow() in
    glfwMakeContextCurrent(w);
    printFrameBufferSize(w);
