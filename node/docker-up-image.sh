#!/bin/bash

cd /workspace
rm -rf build/
webpack-dev-server --history-api-fallback --inline --progress --host 0.0.0.0 --port 80

