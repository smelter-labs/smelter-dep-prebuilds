#!/usr/bin/env bash

#
# Checks if versions for FFmpeg sources are the same
#

set -eo pipefail

if (( $# != 3 )); then
    echo "Usage: $0 <MAC_VERSION> <LINUX_AMD64_VERSION> <LINUX_ARM64_VERSION>"
    exit 1
fi

MAC_VERSION=$1
LINUX_X86_VERSION=$2
LINUX_ARM64_VERSION=$3

if [ -z "$MAC_VERSION" ] && [ -z "$LINUX_X86_VERSION" ] && [ -z "$LINUX_ARM64_VERSION" ]; then
    >&2 echo "No correct build URL was specified"
    exit 1

elif [ -z "$MAC_VERSION" ] && [ -z "$LINUX_X86_VERSION" ]; then
    echo "$LINUX_ARM64_VERSION"

elif [ -z "$MAC_VERSION" ] && [ -z "$LINUX_ARM64_VERSION" ]; then
    echo "$LINUX_X86_VERSION"

elif [ -z "$LINUX_X86_VERSION" ] && [ -z "$LINUX_ARM64_VERSION" ]; then
    echo "$MAC_VERSION"

elif [ -z "$MAC_VERSION" ] && [[ "$LINUX_X86_VERSION" == "$LINUX_ARM64_VERSION" ]]; then
    echo "$LINUX_X86_VERSION"

elif [ -z "$LINUX_X86_VERSION" ] && [[ "$MAC_VERSION" == "$LINUX_ARM64_VERSION" ]]; then
    echo "$MAC_VERSION"

elif [ -z "$LINUX_ARM64_VERSION" ] && [[ "$MAC_VERSION" == "$LINUX_X86_VERSION" ]]; then
    echo "$MAC_VERSION"

elif [[ "$MAC_VERSION" == "$LINUX_X86_VERSION" ]] && [[ "$MAC_VERSION" == "$LINUX_ARM64_VERSION" ]]; then
    echo "$MAC_VERSION"

else 
    >2& echo "Versions do not match"
    exit 1
fi
