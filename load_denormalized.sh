#!/bin/sh
set -e  # exit if anything fails

echo "Loading file: $1"

unzip -p "$1" | sed 's/\\u0000//g' | psql postgresql://postgres:pass@localhost:6998/ -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"

echo "Finished loading: $1"

