type t;

exception ImageLoadException(string);

type successCallback = t => unit;
type failureCallback = string => unit;

type dimensions = {
  width: int,
  height: int,
};

let load: string => Lwt.t(t);
let fromColor: (int, int, int, int) => t;
let getDimensions: t => dimensions;
let debug_print: t => unit;

let create:
  Bigarray.Array2.t(int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) => t;
let destroy: t => unit;
let getPixels:
  t => Bigarray.Array2.t(int, Bigarray.int8_unsigned_elt, Bigarray.c_layout);
let setPixels:
  (
    t,
    Bigarray.Array2.t(int, Bigarray.int8_unsigned_elt, Bigarray.c_layout)
  ) =>
  unit;
let save: (t, string) => unit;
