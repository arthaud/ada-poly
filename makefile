all : p_arbren.o p_arbre_poly.o p_polynome.o

p_polynome.o : p_arbre_poly.o p_polynome.ads p_polynome.adb
	gnatmake p_polynome.adb

p_arbre_poly.o : p_arbre_poly.ads p_arbre_poly.adb
	gnatmake p_arbre_poly.adb

p_arbren.o : p_arbren.ads p_arbren.adb
	gnatmake p_arbren.adb

test: p_arbren_test p_arbre_poly_test p_polynome_test
	./p_arbren_test
	./p_arbre_poly_test
	./p_polynome_test

p_arbren_test: p_arbren.o p_arbren_test.adb
	gnatmake p_arbren_test.adb

p_arbre_poly_test: p_arbre_poly.o p_arbre_poly_test.adb
	gnatmake p_arbre_poly_test.adb

p_polynome_test: p_polynome.o p_polynome_test.adb
	gnatmake p_polynome_test.adb

clean:
	\rm -f *.ali *.o *_test
