open Glfw

let () =
    print_hello ();
    glfwInit();
    let w = glfwCreateWindow 800 600 "test" in
    glfwMakeContextCurrent(w);

    while not (glfwWindowShouldClose w) do
        glClear();
        glfwSwapBuffers(w);
        glfwPollEvents();
        printFrameBufferSize(w);
    done;
    print_endline "Done!";
    glfwTerminate ()
