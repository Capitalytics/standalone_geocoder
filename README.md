Standalone Geocoder

A standalone geocoder, targeted for either Mac or *nix systems, strongly based on that found at https://github.com/geocommons/geocoder, and including a customized sqlite3 driver that is strongly based on that found at http://github.com/schuyler/sqlite3-ruby.  

Notice that this codebase is built with RVM in mind: the ruby version with which it is compatible is given in the file .ruby-version (currently 2.1.4), and the rails version in the Gemfile below is 4.1.15.  

Database is assumed to be a derivative of Sqlite3 that is installated (by root) in a non-standard location per the following ...

```
export GEOSQLITE_LOC=(location for installation)

wget http://www.sqlite.org/sqlite-autoconf-3071300.tar.gz
tar -zxvf sqlite-autoconf-3071300.tar.gz
cd sqlite-autoconf-3071300
CFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA"  ./configure --prefix=$GEOSQLITE_LOC 
make 
sudo make install
```

To install the geocoder ...

```
cd sqlite3_ruby
ruby setup.rb config -- --with-sqlite3-lib=${GEOSQLITE_LOC}/lib --with-sqlite-include=${GEOSQLITE_LOC}/include
ruby setup.rb setup
sudo ruby setup.rb install  

cd ../geocommons_geocoder
make clean
make
```

To build a database ...

```
cd ../geocommons_geocoder/build_db
./create_2017_db.sh
```

Then, copy geocommons_geocoder/lib/geocoder into your ruby application's lib directory, and put the resulting database in an appropriate location (e.g., an etc directory within your codetree).

To use the geocoder, 

```
$ rails c
>> require 'geocoder/us'
=> true
>> db = Geocoder::US::Database.new(Rails.root.join('etc',"geocoder-2017.db").to_s)
=> #<Geocoder::US::Database:0x000000181cf378 @db=#<SQLite3::Database:0x000000181d5250>, @st={}, @dbtype=1, @debug=false, @threadsafe=false>
>> p db.geocode("1600 Pennsylvania Av, Washington DC")
=> [{:street=>"Pennsylvania Ave NW", :zip=>"20502", :city=>"Washington", :state=>"DC", :lat=>38.898672, :lon=>-77.036756, :fips_county=>"11001", :score=>0.841, :prenum=>"", :number=>"1600", :precision=>:range}, {:street=>"Pennsylvania Ave NW", :zip=>"20037", :city=>"Washington", :state=>"DC", :lat=>38.898813, :lon=>-77.039459, :fips_county=>"11001", :score=>0.841, :prenum=>"", :number=>"1600", :precision=>:range}, {:street=>"Pennsylvania Ave SE", :zip=>"20003", :city=>"Washington", :state=>"DC", :lat=>38.878832, :lon=>-76.981641, :fips_county=>"11001", :score=>0.841, :prenum=>"", :number=>"1600", :precision=>:range}]
>> quit
```