#!/bin/sh

## Maintainer: @mioatswivel

sysname=$1
environment=$2

errcheck() {
  if [ $? -eq 1 ]; then
    echo Failed to generate keypair.
    exit 1
  fi
}

# Check if both argument exists, exit if not
if [ -z "$sysname" ] || [ -z "$environment" ]; then
  echo "Usage: $0 <system-name> <environment>"
  exit 1
fi

ssh-keygen -t rsa -b 4096 -f "$sysname.$environment.pri.pem" -m pem -C "$sysname.$environment"
errcheck

ssh-keygen -f "$sysname.$environment.pri.pem.pub" -e -m pem >"$sysname.$environment.pub.pem"
errcheck

rm "$sysname.$environment.pri.pem.pub"
