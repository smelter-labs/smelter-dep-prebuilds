#!/usr/bin/env bash

#
# - Checks if URL points to linux arm64 lgpl shared release in BtbN/FFmpeg-Builds github repo and returns FFmpeg version
# - Returns the FFmpeg version extracted from the URL or empty string if empty input was specified
#

set -eo pipefail

if (( $# != 1 )); then
    >&2 echo "Usage: $0 <FFMPEG_URL>"
    exit 1
fi

FFMPEG_URL=$1

if [ -z "$FFMPEG_URL" ]; then
    echo -n ''
    exit 0
fi

# Checks if provided URL is URL to github BtbN/FFmpeg-Builds repo, and if it is pointing to `linux64-lgpl-shared` file. Captures version in `x.y` format
URL_REGEX="^https://github\.com/BtbN/FFmpeg-Builds/releases/download/.+/ffmpeg-n([0-9]+\.[0-9]+)\.?[0-9]*-?[0-9]*-[a-zA-Z0-9]+-linuxarm64-lgpl-shared-[0-9.]+\.tar\.xz$"

if [[ $FFMPEG_URL =~ $URL_REGEX ]]; then
    URL_VERSION=${BASH_REMATCH[1]}
    echo -n "$URL_VERSION"
else
    >&2 echo "Invalid URL. URL should point to linuxarm64-lgpl-shared file in BtbN/FFmpeg-Builds github repo."
    exit 1
fi


