BUILDDIR=$(ROOTDIR)/_build

ifeq (, $(shell which x86_64-w64-mingw32-g++))
GCC=g++
INCLUDE=$(BUILDDIR)/glfw/include
LIBRARY=$(BUILDDIR)/glfw/src
ADDITIONAL_OPTS=-ccopt "-framework OpenGL" -ccopt "-framework Cocoa" -ccopt "-framework IOKit" -ccopt "-framework CoreVideo"
else
GCC=x86_64-w64-mingw32-g++
GCC_EXTRA_ARGS=-static -static-libgcc -static-libstdc++
INCLUDE=$(ROOTDIR)/include
LIBRARY=$(ROOTDIR)/lib-mingw-w64
ADDITIONAL_OPTS=-cclib -lgdi32
endif

# Building glfw from source
$(INCLUDE)/GLFW/glfw3.h:
	echo Library: $(LIBRARY)
	echo Include: $(INCLUDE)
	mkdir -p $(BUILDDIR)
	git clone https://github.com/glfw/glfw $(BUILDDIR)/glfw

$(LIBRARY)/libglfw3.a: $(INCLUDE)/GLFW/glfw3.h
	cd $(BUILDDIR)/glfw; cmake .
	cd $(BUILDDIR)/glfw; make

build-glfw: $(LIBRARY)/libglfw3.a
	echo "Building lib_glfw"

prep:
	mkdir -p $(BUILDDIR)
	cp *.ml _build
	cp *.mli _build

noop:
	mkdir -p $(BUILDDIR)
	echo "Skip building glfw"

$(BUILDDIR)/glfw.cmi:
	ocamlc -c $(BUILDDIR)/glfw.mli -o $(BUILDDIR)/glfw.cmi

$(BUILDDIR)/glfw.cmo:
	mkdir -p $(BUILDDIR)
	ocamlc -I $(BUILDDIR) -c $(BUILDDIR)/glfw.ml -o $(BUILDDIR)/glfw.cmo

$(BUILDDIR)/glfw.cmx:
	ocamlopt -I $(BUILDDIR) -c $(BUILDDIR)/glfw.ml -o $(BUILDDIR)/glfw.cmx

$(BUILDDIR)/glad.o:
	@$(GCC) -o $(BUILDDIR)/glad.o -I$(OCAMLLIB) -I./include -c ./glad.c

$(BUILDDIR)/glfw_wrapper.o:
	@$(GCC) -o $(BUILDDIR)/glfw_wrapper.o -I$(OCAMLLIB) -I./include -c ./glfw_wrapper.cc

$(BUILDDIR)/glfw.cma:
	ocamlc -a -custom -o $(BUILDDIR)/glfw.cma $(BUILDDIR)/glad.o $(BUILDDIR)/glfw_wrapper.o $(BUILDDIR)/glfw.cmo -ccopt -L$(LIBRARY) -cclib -lglfw3 $(ADDITIONAL_OPTS)

$(BUILDDIR)/glfw.cmxa:
	ocamlopt -a -o $(BUILDDIR)/glfw.cmxa $(BUILDDIR)/glfw.cmx $(BUILDDIR)/glad.o $(BUILDDIR)/glfw_wrapper.o  -ccopt -L$(LIBRARY) -cclib -lglfw3 $(ADDITIONAL_OPTS)

$(BUILDDIR)/test.exe:
	ocamlopt  -o $(BUILDIR)/test_app

build: $(BUILDDIR)/glfw.cmi $(BUILDDIR)/glfw.cmo $(BUILDDIR)/glfw.cmx $(BUILDDIR)/glad.o $(BUILDDIR)/glfw_wrapper.o $(BUILDDIR)/glfw.cmxa $(BUILDDIR)/glfw.cma
	@echo Using compiler: $(GCC) with args: $(GCC_EXTRA_ARGS)
	@echo Compiling to: $(BUILDDIR)
	ocamlopt -I $(BUILDDIR) glfw.cmxa -c test_glfw.ml -o $(BUILDDIR)/test_glfw.cmx
	ocamlopt -I $(BUILDDIR) $(OCAMLLIB)/bigarray.cmxa glfw.cmxa test_glfw.cmx -o $(BUILDDIR)/test_glfw
	#ocamlc -c -I $(BUILDDIR) glfw.cmo -c test_glfw.ml -o $(BUILDDIR)/test_glfw.byte
	#ocamlfind ocamlc -package js_of_ocaml-compiler -linkpkg -o test_glfw.byte $(BUILDDIR)/glfw.cma test_glfw.ml
	ocamlc -g -I $(BUILDDIR) $(OCAMLLIB)/bigarray.cma glfw.cma $(BUILDDIR)/test_glfw.ml -o $(BUILDDIR)/test_glfw.byte
	js_of_ocaml -pretty -no-inline -source-map ./js/stubs.js $(BUILDDIR)/test_glfw.byte -o $(BUILDDIR)/test_glfw.js
