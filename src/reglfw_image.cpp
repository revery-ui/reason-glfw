#include <stdio.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/bigarray.h>

#include "reglfw_image.h"

extern "C" {
    CAMLprim value
    caml_createImage(value vPixels) {
      CAMLparam1(vPixels);

      ReglfwImageInfo *ret = (ReglfwImageInfo *) malloc(sizeof(ReglfwImageInfo));
      caml_setImagePixels((value) ret, vPixels);

      CAMLreturn((value) ret);
    }

    CAMLprim value
    caml_destroyImage(value vImage) {
      CAMLparam1(vImage);

      ReglfwImageInfo *image = (ReglfwImageInfo *) vImage;
      free(image);

      CAMLreturn(Val_unit);
    }

    // TODO make this create a copy to match JS behaviour
    CAMLprim value
    caml_getImagePixels(value vImage) {
      CAMLparam1(vImage);
      CAMLlocal1(ret);
      ReglfwImageInfo *image = (ReglfwImageInfo *) vImage;
      ret = caml_ba_alloc_dims(CAML_BA_UINT8 | CAML_BA_C_LAYOUT, 2, image->data, image->width, image->height);
      CAMLreturn(ret);
    }

    CAMLprim value
    caml_setImagePixels(value vImage, value vPixels) {
      CAMLparam2(vImage, vPixels);
      ReglfwImageInfo *image = (ReglfwImageInfo *) vImage;

      image->width = Caml_ba_array_val(vPixels)->dim[0];
      image->height = Caml_ba_array_val(vPixels)->dim[1];
      image->data = (unsigned char *)Caml_ba_data_val(vPixels);

      CAMLreturn(Val_unit);
    }

    // Based on https://github.com/Jba03/glReadPixels_example/blob/master/tga.cpp
    CAMLprim value
    caml_saveImage(value vImage, value vPath) {
      CAMLparam2(vImage, vPath);
      ReglfwImageInfo *image = (ReglfwImageInfo *) vImage;

      uint8_t tga_header[12] = { 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
      uint8_t bytesPerChannel = 1; // uint8
      uint8_t bytesPerPixel = 4 * bytesPerChannel; // RGBA
      uint8_t bitsPerPixel = 8 * bytesPerPixel;
      // See http://www.paulbourke.net/dataformats/tga/
      uint16_t header[3] = {
        (uint16_t) image->width,
        (uint16_t) image->height,
        (uint16_t) bitsPerPixel // Image descriptor = 0
      };

      const char *path = String_val(vPath);
      FILE *fd = fopen(path, "wb");
      fwrite(tga_header, 1, 12, fd);
      fwrite(header, 2, 3, fd);
      fwrite(image->data, bytesPerPixel, image->width * image->height, fd);
      fclose(fd);

      CAMLreturn(Val_unit);
    }
}
