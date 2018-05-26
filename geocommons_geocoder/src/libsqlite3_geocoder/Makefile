all: sqlite3.so
CC=gcc -fPIC 

#extension.o:
#	$(CC) -lm -lsqlite3_caplyt -L/usr/local/lib -shared $^ -o $@

sqlite3.so: extension.o wkb_compress.o util.o metaphon.o levenshtein.o
#	$(CC) -lm -lsqlite3_caplyt -L/usr/local/lib -I/usr/include -shared $^ -o $@ 
	$(CC) $^ -lm  $(GEOSQLITE_LOC)/libsqlite3.a -shared -o $@ 

test: test_wkb_compress test_levenshtein


test_wkb_compress: wkb_compress.c
	$(CC) -DTEST -o wkb_compress $^

test_levenshtein: levenshtein.c
	$(CC) -DTEST -o levenshtein $^

clean:
	rm -f *.o *.so wkb_compress levenshtein

install:
	cp *.so ../../lib/geocoder/us/sqlite3.so

