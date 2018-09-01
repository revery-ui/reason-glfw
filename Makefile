PREFIX=$(PWD)

ifeq (, $(shell which x86_64-w64-mingw32-g++))
GCC=g++
else
GCC=x86_64-w64-mingw32-g++
GCC_EXTRA_ARGS=-static -static-libgcc -static-libstdc++
endif

build:
	@echo Using compiler: $(GCC) with args: $(GCC_EXTRA_ARGS)
	@mkdir -p $(PREFIX)/bin
	@$(GCC) $(GCC_EXTRA_ARGS) -o$(PREFIX)/bin/fastreplacestring ./fastreplacestring.cpp

test:
	@node ./tests/test.js && node ./tests/xtest.js
