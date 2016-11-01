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

# "g3: switch back to thermal-engine"
cherries+=(CM_168365)

# overlay: launch assist on home long-press
cherries+=(CM_167960)

# g3-common: Use multithread decode for boot animation
cherries+=(CM_168485)

# selinux permissive
cherries+=(CM_167624)

# g3: sepolicy: nougat changes
cherries+=(CM_167837)

# windowmanager: Add support for blur effects
cherries+=(CM_167370)

# g3: move to source-built libril
cherries+=(CM_167835)

# d855: move to source-built libril
cherries+=(CM_167622)

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

# Allow devices to re-integrate cameraserver and mediaserver
# cherries+=(CM_165008)

# allow cameraserver to have the same UID as mediaserver
# cherries+=(CM_165009)

# CameraService: Allow to use CameraSource as metadata buffer type
# cherries+=(CM_165140)

# temp cam source fix for semc2011
# cherries+=(CM_166099)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
