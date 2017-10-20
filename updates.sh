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

# Add cortex-a73 support
cherries+=(LAOS_186075)

# libc: Add kryo specific memcpy
cherries+=(LAOS_186051)

# Add kryo support.
cherries+=(LAOS_185989)

# libc: use Cortex-A7/A53 memset on Kryo
cherries+=(LAOS_185990)

# libc: ARM: Add 32-bit Kryo memcpy 
cherries+=(LAOS_185991)

# Add support for an armv7 variant for Kryo 
cherries+=(LAOS_186003)

# soong: use optimal FPU on Kryo targets
cherries+=(LAOS_186004)

# Add support for an armv8 variant for Kryo
cherries+=(LAOS_186005)

# Make use of specific Kryo targeting in Clang
cherries+=(LAOS_ 186006)

# Add support for cortex-a73
cherries+=(LAOS_186050)

# Add arm neon and mips arch features
cherries+=(LAOS_186074)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
