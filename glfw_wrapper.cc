#include <stdio.h>

#include <caml/mlvalues.h>
#include <GLFW/glfw3.h>

extern "C" {

    CAMLprim value
    caml_print_hello(value unit)
    {
        printf("Hello \n");
        return Val_unit;
    }

    CAMLprim value
    caml_glfwInit(value unit)
    {
        int ret = glfwInit();
        return Val_bool(ret);
    }

    CAMLprim value
    caml_glfwCreateWindow(value unit)
    {
      GLFWwindow* wd;           /* window desciptor/handle */
        if (!glfwInit()) {
            return Val_unit;
        }

      wd = glfwCreateWindow(640, 480, "Experiment with line drawing",
                            NULL, NULL);
      return (value) wd;
    }

    CAMLprim value
    caml_glfwMakeContextCurrent(value window)
    {
        GLFWwindow* wd = (GLFWwindow *)window;
        glfwMakeContextCurrent(wd);
        return Val_unit;
    }

    CAMLprim value
    caml_printFrameBufferSize(value window)
    {

        GLFWwindow *wd = (GLFWwindow*)window;
        int fbwidth;
        int fbheight;
        glfwGetFramebufferSize(wd, &fbwidth, &fbheight);

        printf("size2: %d %d\n", fbwidth, fbheight);
        return Val_unit;
    }
}
