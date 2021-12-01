#!/usr/bin/env bash
set -e

rm -f /myapp/tmp/pids/server.pid

exec "$@"
