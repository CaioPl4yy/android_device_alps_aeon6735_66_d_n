#!/bin/bash
# Extract proprietary blobs from a running device (adb) or from a dumped /system directory.
set -e
DEVICE=aeon6735_66_d_n
VENDOR=eastaeon
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi
LINEAGE_ROOT="$MY_DIR"/../../..
HELPER="$LINEAGE_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then echo "Unable to find helper script at $HELPER"; exit 1; fi
. "$HELPER"

CLEAN_VENDOR=true
while [ "$1" != "" ]; do
    case $1 in
        -n | --no-cleanup ) CLEAN_VENDOR=false ;;
        -s | --section )    shift; SECTION=$1; CLEAN_VENDOR=false ;;
        * )                 SRC=$1 ;;
    esac
    shift
done
if [ -z "$SRC" ]; then SRC=adb; fi

setup_vendor "$DEVICE" "$VENDOR" "$LINEAGE_ROOT" false "$CLEAN_VENDOR"
extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"
"$MY_DIR"/setup-makefiles.sh
