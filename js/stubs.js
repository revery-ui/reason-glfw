//Provides: caml_print_hello
function caml_print_hello() {
    console.log("Hello!");
}

//Provides: caml_glfwInit
function caml_glfwInit() {
    // no-op
};

//Provides: caml_glfwCreateWindow
function caml_glfwCreateWindow(width, height, title) {
    var canvas = document.createElement("canvas");
    canvas.style.position = "absolute";
    canvas.style.top = "0px";
    canvas.style.bottom = "0px";
    canvas.style.width = width.toString() + "px";
    canvas.style.height = height.toString() + "px";

    document.body.appendChild(canvas);
    return {
        canvas: canvas,
        title: title,
    };
};

// Provides: caml_glfwMakeContextCurrent
function caml_glfwMakeContextCurrent(win) {
    var context = win.canvas.getContext('webgl');
    window.__glfw__gl__ = context;

    console.log("set context to: " + win.title)
}

function gl() {
    return window.__glfw__gl__
}

// Provides: caml_glClear
function caml_glClear() {
    debugger;
    gl().clearColor(1, 0, 0, 1);
    gl().clear(gl().COLOR_BUFFER_BIT);
}

// Provides: caml_glfwWindowShouldClose
function caml_glfwWindowShouldClose() {
    return false
}
