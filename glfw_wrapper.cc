#include <stdio.h>
#include <stdlib.h>

#include <caml/mlvalues.h>
/* #include <GLFW/glfw3.h> */

extern "C" {

    CAMLprim value
    caml_print_hello(value unit)
    {
        printf("Hello \n");
        return Val_unit;
    }
}
