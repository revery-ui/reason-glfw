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
    canvas.width = width;
    canvas.height = height;

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

// Provides: caml_glClearColor
function caml_glClearColor(r, g, b, a) {
    gl().clearColor(r, g, b, a);
    gl().clear(gl().COLOR_BUFFER_BIT);
}

// Provides: caml_glClearDepth
function caml_glClearDepth(d) {
    gl().clearDepth(d);
    gl().clear(gl().DEPTH_BUFFER_BIT);
}

// Provides: caml_glfwWindowShouldClose
var i = 0;
function caml_glfwWindowShouldClose() {
    i++
    if (i > 1) {
        return true
    } else {
        return false
    }
}

// Provides: caml_glAttachShader
function caml_glAttachShader(program, shader) {
    gl().attachShader(program, shader);
}

// Provides: caml_glBindBuffer
function caml_glBindBuffer(target, buffer) {
    // TODO: target param
    gl().bindBuffer(gl().ARRAY_BUFFER, buffer)
}

// Provides: caml_glBufferData
function caml_glBufferData(target, size, data, usage) {
    // TODO: Remove size
    gl().bufferData(gl().ARRAY_BUFFER, data.data,  gl().STATIC_DRAW)
}

// Provides: caml_glCompileShader
function caml_glCompileShader(shader) {
    gl().compileShader(shader);
}

// Provides: caml_glCreateBuffer
function caml_glCreateBuffer() {
    return gl().createBuffer();
}

// Provides: caml_glCreateProgram
function caml_glCreateProgram() {
    return gl().createProgram();
}

// Provides: caml_glCreateShader
function caml_glCreateShader(type) {
    console.log("create shader: " + type);
    var glType;
    switch (type) {
        case 0:
            glType = gl().VERTEX_SHADER;
            break;
        case 1:
            glType = gl().FRAGMENT_SHADER;
            break;
        default:
            throw "Unrecognized shader type";
    }
    return gl().createShader(glType);
}

// Provides: caml_glDepthFunc
function caml_glDepthFunc(df) {
    // TODO: Use df parameter
    gl().depthFunc(gl().LEQUAL);
}

// Provides: caml_glDrawArrays
function caml_glDrawArrays(drawMode, first, count) {
    // TODO: Use params
    gl().drawArrays(gl().TRIANGLES, 0, 3);
}

// Provides: caml_glEnable
function caml_glEnable(option) {
    // TODO: Use params
    gl().enable(gl().DEPTH_TEST)
}

// Provides: caml_glGetShaderIsCompiled
function caml_glGetShaderIsCompiled() {
    // TODO: Refactor this
    return true;
}

// Provides: caml_glLinkProgram
function caml_glLinkProgram(program) {
    gl().linkProgram(program);
}

// Provides: caml_glShaderSource
function caml_glShaderSource(shader, src) {
    gl().shaderSource(shader, src);
}

// Provides: caml_glUseProgram
function caml_glUseProgram(program) {
    gl().useProgram(program);
}

// Provides: caml_glVertexAttribPointer
function caml_glVertexAttribPointer() {
    // TODO: PARAMS!
    gl().vertexAttribPointer(0, 3, gl().FLOAT, false, 0, 0);
}

// Provides: caml_glEnableVertexAttribArray
function caml_glEnableVertexAttribArray() {
    // TODO: Params
    gl().enableVertexAttribArray(0);
}

// Provides: caml_glfwPollEvents
function caml_glfwPollEvents() {
    // no op
}

// Provides: caml_glfwSwapBuffers
function caml_glfwSwapBuffers() {
    // no op
}

// Provides: caml_glfwTerminate
function caml_glfwTerminate() {
    // no op
}
