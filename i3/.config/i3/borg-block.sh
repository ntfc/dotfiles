#!/usr/bin/env bash

# returns json output, or empty if borg is not setup

set -e

function is_borgmatic_enabled() {
  if systemctl is-enabled --quiet borgmatic.timer; then
    true
  else
    false
  fi
}

function is_borgmatic_running() {
  if systemctl status borgmatic.service | grep --quiet --extended-regexp "Active: (activating|active)"; then
    true
  else
    false
  fi
}

function is_borgmatic_failed() {
  if systemctl is-failed --quiet borgmatic.service; then
    true
  else
    false
  fi
}


if is_borgmatic_enabled; then
  if is_borgmatic_running; then
    TEXT="in progress.."
    STATE="Info"
  else
    if is_borgmatic_failed; then
      TEXT="failed"
      STATE="Critical"
    else
      TEXT="waiting"
      STATE="Idle"
    fi
  fi
  echo '{"icon": "file_archive", "text": "'$TEXT'", "state": "'$STATE'"}'
else
  # echo nothing
  echo '{"text": ""}'
fi

