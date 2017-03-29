#!/usr/bin/env bash

outfile=$1
for i in {1..10}; do
    curl "http://www.jazzstandards.com/compositions/index${i}.htm" | grep '<tr' | grep '<a' | sed 's/.*<a.*>\(.*\)<\/a>.*/\1/'
done
