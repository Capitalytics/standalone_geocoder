Standalone Geocoder

A standalone geocoder, targeted for either Mac or *nix systems, strongly based on that found at https://github.com/geocommons/geocoder.

Database is assumed to be a derivative of Sqlite3 that is installated (by root) in a non-standard location per the following ...

cd /tmp; wget http://www.sqlite.org/sqlite-autoconf-3071300.tar.gz
tar -zxvf sqlite-autoconf-3071300.tar.gz
cd sqlite-autoconf-3071300
export GEOSQLITE_LOC="/usr/caplyt/sqlite3"
CFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA"  ./configure --prefix=$GEOSQLITE_LOC ; make ; make install

This repository does leverad the GEOSQLITE_LOC environment variable for the location of the non-standard sqlite3 installation.
