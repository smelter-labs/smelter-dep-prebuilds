#!/usr/bin/env bash

#
# - Checks if URL points to official FFmpeg github repo and if it points to `*.tar.gz` archive
# - Returns the FFmpeg version extracted from the URL
#

set -eo pipefail

if (( $# != 1 )); then
    echo "Usage: $0 <FFMPEG_URL>"
    exit 1
fi

FFMPEG_URL=$1

# Checks if provided URL is URL to github FFmpeg repo, and if it is pointing to `*.tar.gz` file. Captures version in `x.y` format
URL_REGEX="^https://github\.com/FFmpeg/FFmpeg/archive/refs/tags/n([0-9]+\.[0-9]+)\.?[0-9]*\.tar\.gz$"

if [[ $FFMPEG_URL =~ $URL_REGEX ]]; then
    URL_VERSION=${BASH_REMATCH[1]}
    echo -n "$URL_VERSION"
else
    echo "Invalid URL. URL should point to *.tar.gz file in FFmpeg github repo."
    exit 1
fi


