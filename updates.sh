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

#Cherries needed for G3

# diagchar: use diag, not diag_lge
cherries+=(CM_167836)

# overlay: launch assist on home long-press
cherries+=(CM_167960)

# selinux permissive
cherries+=(CM_167624)

# g3: sepolicy: nougat changes
cherries+=(CM_167837)

# windowmanager: Add support for blur effects
cherries+=(CM_167370)

# g3: move to source-built libril
cherries+=(CM_167835)

# init: always run baseband-sh
cherries+=(CM_167787)

#Cherrys needed for ANZU and G3

# sad selinux 2002
cherries+=(CM_167621)


# Cherrys needed for ANZU

# libc: use 128-bit cache line size memmove on scorpion
cherries+=(CM_167386)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_167387)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_167388)

# av: Add support for CameraSource as metadata type
cherries+=(CM_167485)

# Add rules required for TARGET_HAS_LEGACY_CAMERA_HAL1
cherries+=(CM_167484)


if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
