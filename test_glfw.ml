open Glfw

let loadShader shaderType source =
    let shader = glCreateShader shaderType in
    let () = glShaderSource shader source in
    let () = glCompileShader shader in
    let compileResult = glGetShaderIsCompiled shader in
    compileResult

let () =
    print_hello ();
    glfwInit();
    let w = glfwCreateWindow 800 600 "test" in
    glfwMakeContextCurrent(w);

    let vsSource = {|
        attribute vec4 aVertexPosition;

        void main() {
            gl_Position = aVertexPosition;
        }
    |} in
    print_endline(vsSource);
    let fsSource = {|
        void main() {
            gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
    |} in
    print_endline(fsSource);

    let vShader = loadShader GL_VERTEX_SHADER vsSource in
    let fShader = loadShader GL_FRAGMENT_SHADER fsSource in

    while not (glfwWindowShouldClose w) do
        glClearColor 1.0 0. 1. 1.;
        glfwSwapBuffers(w);
        glfwPollEvents();
    done;
    print_endline "Done!";
    glfwTerminate ();
