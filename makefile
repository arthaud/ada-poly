all : p_arbren.o

p_arbren.o : p_arbren.ads p_arbren.adb
	gnatmake p_arbren.adb

test: p_arbren.o p_arbren_test
	./p_arbren_test

p_arbren_test: p_arbren_test.adb
	gnatmake p_arbren_test.adb

clean:
	\rm -f *.ali *.o *_test
