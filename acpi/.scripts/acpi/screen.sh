#!/bin/sh

set -e

hash mons &> /dev/null || echo "error: mons is not installed"

# for now, just activate the preferred monitor. this is used as a way to
# restore a usable monitor if external monitor is abruptly disconnected
mons -o

