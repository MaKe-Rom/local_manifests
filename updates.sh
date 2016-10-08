#!/bin/bash

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

android="${PWD}"

# Add local cherries if they exist
if [ -f ${android}/updates-local.sh ]; then
    source ${android}/updates-local.sh
fi

# g3 overlays
cherries+=(CM_159133)

# g selinux
cherries+=(CM_161956)

# sad selinux 2002
cherries+=(CM_164156)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_164317)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_164318)

# msm7x30: add imgdiff dependency
cherries+=(LX_1383)

# defconfigs: Enable lzma support for kernel and combined ramdis
cherries+=(LX_1385)

# msm7x30: pack ramdisk with lzma instead of gzip
cherries+=(LX_1386)

# f2fs: Squashed update from f2fs-stable linux-3.4.y
cherries+=(LX_1396)

# policy_hal: Update for N
cherries+=(LX_1353)


if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
