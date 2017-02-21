#!/usr/bin/env bash

set -e

if hash nc 2>/dev/null; then
  # check for internet connectivity
  # from http://unix.stackexchange.com/a/190610
  if nc -dzw1 google.com 443 && echo |openssl s_client -connect $test:443 2>&1 |awk 'handshake && $1 == "Verification" { if ($2=="OK") exit; exit 1 } $1 $2 == "SSLhandshake" { handshake = 1 }'; then
    vdirsyncer sync
  else
    echo "ERROR: No connectivity"
    exit 1
  fi
else
  echo "ERROR: nc not installed: I can't verify if there is connectivity!"
  exit 1
fi

