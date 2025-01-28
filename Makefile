all: build

.PHONY: build
build:
	dub build --parallel --build-mode=singleFile --compiler=ldc2 --debug debug

.PHONY: clean
clean:
	dub clean
	-rm -f gidgen
