open Glfw

let loadShader shaderType source =
    let shader = glCreateShader shaderType in
    let () = glShaderSource shader source in
    let () = glCompileShader shader in
    let _ = glGetShaderIsCompiled shader in
    shader

let initShaderProgram vsSource fsSource =
    let vsShader = loadShader GL_VERTEX_SHADER vsSource in
    let fsShader = loadShader GL_FRAGMENT_SHADER fsSource in
    let shaderProgram = glCreateProgram () in
    let () = glAttachShader shaderProgram vsShader in
    let _ = glAttachShader shaderProgram fsShader in
    let result = glLinkProgram shaderProgram in
    shaderProgram

let () =
    print_hello ();
    glfwInit ();
    let w = glfwCreateWindow 800 600 "test" in
    glfwMakeContextCurrent(w);

    let vsSource = {|
        attribute vec3 aVertexPosition;

        void main() {
            gl_Position = vec4(aVertexPosition, 1.0);
        }
    |} in
    print_endline(vsSource);
    let fsSource = {|
        void main() {
            gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
    |} in
    print_endline(fsSource);

    let positions = [|-0.5; -0.5; 0.0; 0.5; -0.5; 0.0; 0.0; 0.5; 0.0|] in
    let vArray = Bigarray.Array1.of_array Bigarray.Float32 Bigarray.C_layout positions in
    print_endline ("from ocaml: " ^ string_of_float (Bigarray.Array1.get vArray 0));
    let shaderProgram = initShaderProgram vsSource fsSource in
    let vao = glCreateVertexArray () in
    let vb = glCreateBuffer () in
    glBindVertexArray vao;
    glBindBuffer GL_ARRAY_BUFFER vb;
    glBufferData GL_ARRAY_BUFFER 9 vArray GL_STATIC_DRAW;
    print_endline ("from ocaml: " ^ string_of_float (Bigarray.Array1.get vArray 1));
    glVertexAttribPointer 0 3 GL_FLOAT false;
    glEnableVertexAttribArray 0;


    while not (glfwWindowShouldClose w) do
        glClearColor 0.0 0. 0. 1.;
        glClearDepth 1.0;
        glEnable GL_DEPTH_TEST;
        glDepthFunc GL_LEQUAL;

        glUseProgram shaderProgram;
        glBindBuffer GL_ARRAY_BUFFER vb;
        glVertexAttribPointer 0 3 GL_FLOAT false;
        glEnableVertexAttribArray 0;
        glDrawArrays GL_TRIANGLES 0 3;

        glfwSwapBuffers(w);
        glfwPollEvents();
    done;
    print_endline "Done!";
    glfwTerminate ();
