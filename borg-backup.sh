#!/usr/bin/env bash
set -euo pipefail

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

export PATH="$PATH:/usr/local/bin/"

# shellcheck disable=SC1091
. ./borg-env.sh

borg create \
  --verbose \
  --stats \
  --show-rc \
  --compression lz4 \
  --exclude-caches \
  ::'{hostname}-{now}' \
  /tmp/lvm_backup
