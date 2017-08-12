.PHONY: package
package: ./myhtml-c/lib/static_libmyhtml.a

./myhtml-c:
	git clone https://github.com/lexborisov/myhtml.git ./myhtml-c
	cd myhtml-c && git reset --hard b473eb71c8150a3bb274ebb1de916574eb15e7d1

./myhtml-c/lib/static_libmyhtml.a: ./myhtml-c
	cd myhtml-c && make MyHTML_BUILD_SHARED=OFF MyHTML_BUILD_WITHOUT_THREADS=YES MyHTML_OPTIMIZATION_LEVEL=-O3

.PHONY: clean
clean:
	rm -rf myhtml-c
