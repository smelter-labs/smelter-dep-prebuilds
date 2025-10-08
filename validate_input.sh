#!/usr/bin/env bash

set -eo pipefail

if (( $# < 2 )); then
    echo "Usage: $0 <FFMPEG_VERSION> <FFMPEG_URL>"
    exit 1
fi

FFMPEG_VERSION=$1
FFMPEG_URL=$2

VERSION_REGEX="^[0-9]+\.[0-9]+$"
if ! [[ $FFMPEG_VERSION =~ $VERSION_REGEX ]]; then
    echo "Invalid version format, please specify version as 'x.y' where 'x' is major and 'y' is minor verion. Do not specify patch."
    exit 1
fi

# Checks if provided URL is URL to github FFmpeg repo, and if it is pointing to `*.tar.gz` file. Captures version in `x.y` format
URL_REGEX="^https://github\.com/FFmpeg/FFmpeg/archive/refs/tags/n([0-9]+\.[0-9]+)\.?[0-9]*\.tar\.gz$"

if [[ $FFMPEG_URL =~ $URL_REGEX ]]; then
    URL_VERSION=${BASH_REMATCH[1]}
    if [[ "$FFMPEG_VERSION" != "$URL_VERSION" ]]; then
        echo "Input FFmpeg version doesn't match URL FFmpeg version"
        echo "INPUT_VERSION=$FFMPEG_VERSION"
        echo "URL_VERSION=$URL_VERSION"
        exit 1
    fi
else
    echo "Invalid URL. URL should point to *.tar.gz file in FFmpeg github repo."
    exit 1
fi


