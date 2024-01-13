.PHONY: build
build:
	dub build --parallel --compiler=ldc2 --debug debug

.PHONY: coverage
coverage:
	dub build --parallel --compiler=ldc2 --build unittest-cov

.PHONY: test
test: coverage run-test

.PHONY: run-test
run-test:
	./gi-d

.PHONY: format
format:
	dub run dfmt --compiler=ldc2 -- --inplace src
