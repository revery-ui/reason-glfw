PREFIX=$(PWD)

ifeq (, $(shell which x86_64-w64-mingw32-g++))
GCC=g++
else
GCC=x86_64-w64-mingw32-g++
GCC_EXTRA_ARGS=-static -static-libgcc -static-libstdc++
endif

build:
	@echo Using compiler: $(GCC) with args: $(GCC_EXTRA_ARGS)
	@echo Compiling to: $(PREFIX)/bin
	@mkdir -p $(PREFIX)/bin
	@$(GCC) -I$(OCAMLLIB) -I$(PREFIX)/include -c ./glfw_wrapper.cc
	ocamlmklib -o glfw_wrapper_stubs $(PREFIX)/bin/glfw_wrapper.o
	ocamlc -i glfw.ml > glfw.mli
	ocamlc -c glfw.mli
	ocamlc -c glfw.ml
	ocamlc -a -custom -o glfw.cma glfw.cmo -dllib dllglfw_wrapper_stubs.dll
	ocamlopt -c glfw.ml
	ocamlopt glfw_wrapper.o glfw.cmx -o test_app -ccopt -L$(PREFIX)/lib-mingw-w64 -cclib -lglfw3 -cclib -lgdi32 -cclib -lopengl32
	#ocamlopt -a -o glfw.cmxa glfw.cmx -ccopt -cclib -lwrap_stubs -lglfw3 -lgdi32 -lopengl32

test:
	@node ./tests/test.js && node ./tests/xtest.js
