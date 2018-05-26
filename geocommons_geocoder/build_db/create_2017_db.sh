#!/bin/bash

echo "Making temporary directory"
mkdir /tmp/tiger
cd /tmp/tiger

echo "Retrieving EDGE files"
wget ftp://ftp2.census.gov/geo/tiger/TIGER2017/EDGES/* 
echo "Retrieving ADDR files"
wget ftp://ftp2.census.gov/geo/tiger/TIGER2017/ADDR/* 
echo "Retrieving ADDRFN files"
wget ftp://ftp2.census.gov/geo/tiger/TIGER2017/ADDRFN/*
echo "Retrieving FEATNAMES files"
wget ftp://ftp2.census.gov/geo/tiger/TIGER2017/FEATNAMES/*

echo "Importing shape files"
./tiger_import /tmp/geocoder-2017.db /tmp/tiger

echo "Deleting temporary directory"
rm -rf /tmp/tiger

echo "Installing text gem"
gem install text

echo "Rebuilding metaphones"
ruby ./rebuild_metaphones /tmp/geocoder-2017.db

echo "Uninstalling text gem"
gem uninstall text

echo "Building indexes"
./build_indexes /tmp/geocoder-2017.db

echo "Clustering database."
./rebuild_cluster /tmp/geocoder-2017.db

echo "Database completed."