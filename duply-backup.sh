#!/usr/bin/env bash
set -euo pipefail

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# shellcheck disable=SC1091
. ./duply-env.sh

duply "${DUPLY_PROFILE}" backup
