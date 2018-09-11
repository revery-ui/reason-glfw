#include <stdio.h>

#include <caml/mlvalues.h>
#include <glad/glad.h>

#define GLFW_INCLUDE_NONE

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
    caml_glfwCreateWindow(value iWidth, value iHeight, value sTitle)
    {
      GLFWwindow* wd;           /* window desciptor/handle */
      int w = Int_val(iWidth);
      int h = Int_val(iHeight);
      char *s = String_val(sTitle);

      wd = glfwCreateWindow(w, h, s,
                            NULL, NULL);
      return (value) wd;
    }

    CAMLprim value
    caml_glfwMakeContextCurrent(value window)
    {
        GLFWwindow* wd = (GLFWwindow *)window;
        glfwMakeContextCurrent(wd);
        gladLoadGLES2Loader((GLADloadproc) glfwGetProcAddress);
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

    CAMLprim value
    caml_glfwWindowShouldClose(value window)
    {
        GLFWwindow *wd = (GLFWwindow*)window;
        int val = glfwWindowShouldClose(wd);
        return Val_bool(val);
    }

    CAMLprim value
    caml_glfwPollEvents(value unit) 
    {
        glfwPollEvents();
        return Val_unit;
    }

    CAMLprim value
    caml_glClearColor(value vr, value vg, value vb, value va) {
        float r = Double_val(vr);
        float g = Double_val(vg);
        float b = Double_val(vb);
        float a = Double_val(va);
        glClearColor(r, g, b, a);
        glClear(GL_COLOR_BUFFER_BIT);
        return Val_unit;
    }

    CAMLprim value
    caml_glCreateShader(value v) {
        int shaderType;
        switch (Int_val(v)) {
            case 0:
                printf("vertex shader");
                shaderType = GL_VERTEX_SHADER;
                break;
            default:
            case 1:
                printf("fragment shader");
                shaderType = GL_FRAGMENT_SHADER;
                break;
        }

        return (value) glCreateShader(shaderType);
    }

    CAMLprim value
    caml_glShaderSource(value vShader, value vSource) {
        GLuint shader = (GLuint)vShader;
        char *s;
        s = String_val(vSource);
        glShaderSource(shader, 1, &s, NULL);
        return Val_unit;
    }

    CAMLprim value
    caml_glCompileShader(value vShader) {
        GLuint shader = (GLuint)vShader;
        glCompileShader(shader);
        return Val_unit;
    }

    CAMLprim value
    caml_glDeleteShader(value vShader) {
        GLuint shader = (GLuint)vShader;
        glDeleteShader(shader);
    }

    CAMLprim value
    caml_glGetShaderIsCompiled(value vShader) {
        GLuint shader = (GLuint)vShader;

        GLint result;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &result);

        if (result == GL_TRUE) {
            printf("Compiled! %d\n", shader);
            return Val_true;
        } else {
            printf("Not compiled! %d\n", shader);
            char infoLog[512];
            glGetShaderInfoLog(shader, 512, NULL, infoLog);
            printf("Output: %s\n", infoLog);
            return Val_false;
        }
    }

    CAMLprim value
    caml_glfwSwapBuffers(value window)
    {
        GLFWwindow *wd = (GLFWwindow*)window;
        glfwSwapBuffers(wd);
        return Val_unit;
    }

    CAMLprim value
    caml_glfwTerminate(value unit)
    {
        glfwTerminate();
        return Val_unit;
    }
}
