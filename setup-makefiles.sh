#!/bin/bash
set -e
DEVICE=aeon6735_66_d_n
VENDOR=eastaeon
INITIAL_COPYRIGHT_YEAR=2026
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi
LINEAGE_ROOT="$MY_DIR"/../../..
HELPER="$LINEAGE_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then echo "Unable to find helper script at $HELPER"; exit 1; fi
. "$HELPER"

setup_vendor "$DEVICE" "$VENDOR" "$LINEAGE_ROOT"
write_headers
write_makefiles "$MY_DIR"/proprietary-files.txt
write_footers
