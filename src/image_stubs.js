// Provides: caml_getPixelArray
function caml_getPixelArray(image) {
  var canvas = document.createElement("canvas");
  canvas.width = image.naturalWidth;
  canvas.height = image.naturalHeight;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(image, 0, 0);
  var imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
  return new joo_global_object.Uint8Array(imageData.data.buffer);
}

// Based on https://gist.github.com/liabru/11263260
// and https://ourcodeworld.com/articles/read/189/how-to-create-a-file-and-generate-a-download-with-javascript-in-the-browser-without-a-server
// Provides: caml_downloadImage
function caml_downloadImage(filename, text) {
  var blob = new joo_global_object.Blob([text], {
    type: "application/octet-binary"
  });

  var downloadImageAnchor;
  if (!joo_global_object.downloadImageAnchor) {
    downloadImageAnchor = document.createElement("a");
    document.body.appendChild(downloadImageAnchor);
    downloadImageAnchor.style.display = "none";
    joo_global_object.downloadImageAnchor = downloadImageAnchor;
  } else {
    // We need to revoke ObjectURLs because they don't get collected by the
    // browser GC.
    downloadImageAnchor = joo_global_object.downloadImageAnchor;
    var objUrl = downloadImageAnchor.getAttribute("href");
    joo_global_object.URL.revokeObjectURL(objUrl);
  }

  downloadImageAnchor.setAttribute(
    "href",
    joo_global_object.URL.createObjectURL(blob)
  );
  downloadImageAnchor.setAttribute("download", filename);

  downloadImageAnchor.click();
}

// Provides: caml_createImage
function caml_createImage(width, height) {
  return new joo_global_object.Image(width, height);
}

// Provides: caml_destroyImage
function caml_destroyImage(image) {
  // no op
}

// Provides: getImagePixels
// Requires: caml_ba_create_from
// Requires: caml_getPixelArray
function getImagePixels(image) {
  var pixels = caml_getPixelArray(image);
  return caml_ba_create_from(
    pixels,
    null,
    0, // general type
    3, // kind: uint8
    0, // c layout
    [image.width, image.height]
  );
}

// Provides: setImagePixels
function setImagePixels(image, vPixels) {
  if (image.src) {
    try {
      joo_global_object.URL.revokeObjectURL(image.src);
    } catch (error) {}
  }

  var pixels = vPixels.data;
  var blob = new joo_global_object.Blob([pixels], { type: "image/bmp" });
  var objectUrl = joo_global_object.URL.createObjectURL(blob);

  image.src = objectUrl;
}

// Provides: caml_saveImage
// Requires: caml_getPixelArray
// Requires: caml_downloadImage
function caml_saveImage(image, path) {
  var pixels = caml_getPixelArray(image);
  var buffer = new joo_global_object.ArrayBuffer(18 + pixels.byteLength);
  var bufferView = new joo_global_object.DataView(buffer);

  var tgaHeader = [0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var bitsPerPixel = 8 * 4; // RGBA
  var pixelHeader = [image.width, image.height, bitsPerPixel];

  // Copy in all the data to the new buffer
  var bufferIndex = 0;
  for (var i = 0; i < tgaHeader.length; i++) {
    bufferView.setUint8(bufferIndex, tgaHeader[i]);
    bufferIndex++;
  }
  for (var i = 0; i < pixelHeader.length; i++) {
    // The true parameter tells this to use little endianness, which
    // is required for the TGA file
    bufferView.setUint16(bufferIndex, pixelHeader[i], true);
    bufferIndex += 2;
  }
  for (var i = 0; i < image.data.length; i++) {
    bufferView.setUint8(bufferIndex, image.data[i]);
    bufferIndex++;
  }

  caml_downloadImage(path, bufferView);
}
