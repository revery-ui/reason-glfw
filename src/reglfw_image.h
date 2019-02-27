extern "C" {
    struct ReglfwImageInfo {
        int width;
        int height;

        // Actual data - should be width*height*4 bytes due to RGBA layout
        unsigned char* data;
    };

    CAMLprim value
    caml_createImage(value vPixels);

    CAMLprim value
    caml_destroyImage(value vImage);

    CAMLprim value
    caml_getImagePixels(value vImage);

    CAMLprim value
    caml_setImagePixels(value vImage, value vPixels);

    CAMLprim value
    caml_saveImage(value vImage, value path);
}
