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

# rild: support to provide RIL V11 ABI if libril is prebuilt
cherries+=(CM_164393)

# Support setting RIL's socket names via system property
cherries+=(CM_164952)

# g3: sepolicy: nougat changes
cherries+=(CM_161956)

#Cherrys needed for ANZU and G3

# sad selinux 2002
cherries+=(CM_164156)

#Cherrys needed for ANZU

# windowmanager: Add support for blur effects
cherries+=(CM_164162)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_164317)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_164318)

# Allow devices to re-integrate cameraserver and mediaserver
cherries+=(CM_165008)

# allow cameraserver to have the same UID as mediaserver
cherries+=(CM_165009)

# CameraService: Allow to use CameraSource as metadata buffer type
cherries+=(CM_165140)

# temp cam source fix for semc2011
cherries+=(CM_166099)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
