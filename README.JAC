For some reason gfortran can't find some of the libraries as it is installed.
The dirty way to work around this is to run

$ python setup.py install

This will hit compile errors; e.g.

    ld: library not found for -lbundle1.o
    collect2: error: ld returned 1 exit status
    ld: library not found for -lbundle1.o
    collect2: error: ld returned 1 exit status
    error: Command "/usr/local/bin/gfortran -Wall -g -m64 -Wall -g -undefined dynamic_lookup -bundle build/temp.macosx-10.5-x86_64-2.7/src/_loess.o                    \
       build/temp.macosx-10.5-x86_64-2.7/src/loess.o build/temp.macosx-10.5-x86_64-2.7/src/loessc.o build/temp.macosx-10.5-x86_64-2.7/src/misc.o                       \
       build/temp.macosx-10.5-x86_64-2.7/src/predict.o -L/Users/jim.crotinger/anaconda/lib -L/usr/local/Cellar/gcc/5.2.0/lib/gcc/5/gcc/x86_64-apple-darwin14.4.0/5.2.0 \
       -L/Users/jim.crotinger/anaconda/lib -Lbuild/temp.macosx-10.5-x86_64-2.7 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lfloess -lgfortran    \
       -o build/lib.macosx-10.5-x86_64-2.7/pyloess/_loess.so" failed with exit status 1

Copy the quoted command line from the error message and add "-L/usr/lib":

    $ /usr/local/bin/gfortran -L/usr/lib -Wall -g -m64 -Wall -g -undefined dynamic_lookup -bundle build/temp.macosx-10.5-x86_64-2.7/src/_loess.o                           \
           build/temp.macosx-10.5-x86_64-2.7/src/loess.o build/temp.macosx-10.5-x86_64-2.7/src/loessc.o build/temp.macosx-10.5-x86_64-2.7/src/misc.o                       \
	   build/temp.macosx-10.5-x86_64-2.7/src/predict.o -L/Users/jim.crotinger/anaconda/lib -L/usr/local/Cellar/gcc/5.2.0/lib/gcc/5/gcc/x86_64-apple-darwin14.4.0/5.2.0 \
	   -L/Users/jim.crotinger/anaconda/lib -Lbuild/temp.macosx-10.5-x86_64-2.7 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lfloess -lgfortran    \
	   -o build/lib.macosx-10.5-x86_64-2.7/pyloess/_loess.so

This should work.

Now re-run `python setup.py install` and repeat until all of the modules are rebuilt and the package installs.
