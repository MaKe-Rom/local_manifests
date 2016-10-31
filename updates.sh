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

#Cherrys needed for G3

# fix external storage exporting incorrect uid
cherries+=(CM_168012)

# Flag files as non-mappable
cherries+=(CM_168371)

# "g3: switch back to thermal-engine"
cherrie+=(CM_168365)

# overlay: launch assist on home long-press
cherries+=(CM_167960)

# g3-common: Use multithread decode for boot animation
cherries+=(CM_168485)

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
