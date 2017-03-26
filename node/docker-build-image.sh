#!/bin/bash

apt-get update && apt-get install -y man htop

yarn global add rimraf npm-cache

#npm-cache install -c /tmp/npm-cache
npm install --cache-min 999999999 --cache /tmp/npm-cache

rm -rf build/
webpack --progress
webpack-dev-server --history-api-fallback --inline --progress
#npm run build

