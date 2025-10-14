# Smelter prebuilt dependencies
This repo is used to build `FFmpeg` shared libraries for Apple silicon Mac or for redistribution of prebuilt libraries from
[BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds/releases) repo.

## Build new FFmpeg version
- To create new release you need to acquire URL for `FFmpeg` sources (for MacOS) or/and for `FFmpeg` pre built binaries in
  [BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds/releases) repo.
- To create new MacOS build go to official [FFmpeg repository](https://github.com/FFmpeg/FFmpeg/tags) and copy URL of source code in `*tar.gz` format for desired version.
- To create new Linux build go to [BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds/releases) repository and copy URL to desired `FFmpeg` prebuilt version.  
  **IMPORTANT**: URL has to point either to build which contains `linux64-lgpl-shared` or `linuxarm64-lgpl-shared` in its name. Otherwise workflow fill fail.
- Start [Build FFmpeg](https://github.com/smelter-labs/smelter-dep-prebuilds/actions/workflows/build_ffmpeg.yml) action from the `main` branch.
- Paste the links in the appropriate fields. For worflow to be successful at least one URL has to be specified.
    - If more than one URL is specified, all links need to point to the same `FFmpeg` version. Release name is in format `nMAJOR.MINOR` and is derived from supplied URLs.
    - If workflow is run for already existing version the new files will be added to the release and will replace existing ones. If an existing file was not included in
      the consecutive run it will be left as is.
- Start workflow.

## Adjust Smelter
- In [Smelter](https://github.com/software-mansion/smelter) find `tools` crate.
- Find `utils.rs` file in `package_for_release` bin.
- In `ffmpeg_url()` function add `URL` pointing to the archive containing newly built FFmpeg release.

