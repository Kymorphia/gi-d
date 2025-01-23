all:
	@echo "Running all tests"
	find . -maxdepth 1 -type d -not -name "." -printf "%f\n" | xargs -ti bash -c 'LD_LIBRARY_PATH={} dub test :{} --compiler=ldc2'

clean:
	@find . -maxdepth 1 -type d -not -name "." -printf "%f\n" | xargs -i bash -c 'rm -f {}/*.so {}/test-*-application'
