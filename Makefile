ifeq (, $(shell which x86_64-w64-mingw32-g++))
GCC=g++
else
GCC=x86_64-w64-mingw32-g++
GCC_EXTRA_ARGS=-static -static-libgcc -static-libstdc++
endif

$(BUILDDIR)/glfw.cmo:
	mkdir -p $(BUILDDIR)
	ocamlc -c glfw.ml -o $(BUILDDIR)/glfw.cmo

$(BUILDDIR)/glfw.cmx:
	ocamlopt -c glfw.ml -o $(BUILDDIR)/glfw.cmx

$(BUILDDIR)/glfw_wrapper.o:
	@$(GCC) -o $(BUILDDIR)/glfw_wrapper.o -I$(OCAMLLIB) -I./include -c ./glfw_wrapper.cc

$(BUILDDIR)/glfw.cma:
	ocamlc -a -custom -o $(BUILDDIR)/glfw.cma $(BUILDDIR)/glfw_wrapper.o $(BUILDDIR)/glfw.cmo -ccopt -L$(PWD)/lib-mingw-w64 -cclib -lglfw3 -cclib -lgdi32 -cclib -lopengl32
$(BUILDDIR)/glfw.cmxa:
	ocamlopt -a -o $(BUILDDIR)/glfw.cmxa $(BUILDDIR)/glfw.cmx $(BUILDDIR)/glfw_wrapper.o  -ccopt -L$(PWD)/lib-mingw-w64 -cclib -lglfw3 -cclib -lgdi32 -cclib -lopengl32

$(BUILDDIR)/test.exe:
	ocamlopt  -o $(BUILDIR)/test_app

build: $(BUILDDIR)/glfw.cmo $(BUILDDIR)/glfw.cmx $(BUILDDIR)/glfw_wrapper.o $(BUILDDIR)/glfw.cmxa $(BUILDDIR)/glfw.cma
	@echo Using compiler: $(GCC) with args: $(GCC_EXTRA_ARGS)
	@echo Compiling to: $(BUILDDIR)
	ocamlopt -I $(BUILDDIR) glfw.cmxa -c test_glfw.ml -o $(BUILDDIR)/test_glfw.cmx
	ocamlopt -I $(BUILDDIR) glfw.cmxa test_glfw.cmx -o $(BUILDDIR)/test_glfw
	#ocamlc -c -I $(BUILDDIR) glfw.cmo -c test_glfw.ml -o $(BUILDDIR)/test_glfw.byte
	#ocamlfind ocamlc -package js_of_ocaml-compiler -linkpkg -o test_glfw.byte $(BUILDDIR)/glfw.cma test_glfw.ml
	ocamlc -I $(BUILDDIR) glfw.cma test_glfw.ml -o $(BUILDDIR)/test_glfw.byte
	js_of_ocaml ./js_package/stubs.js $(BUILDDIR)/test_glfw.byte -o $(BUILDDIR)/test_glfw.js
