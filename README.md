# Build FFmpeg dynamic libraries

## Build new FFmpeg version
- To start build first visit [FFmpeg repository](https://github.com/FFmpeg/FFmpeg/tags) and pick a release.
- Copy `URL` of sources in `*.tar.gz` format.
- Start action from `master` branch (or your own branch if you made any changes to the workflow or `change_deps.sh`).
- In `tag` field enter FFmpeg version in **X.Y** format.
- In `source_url` field enter the `URL` to FFmpeg sources.
- Start workflow.

## Adjust Smelter
- In [Smelter](https://github.com/software-mansion/smelter) find `tools` crate.
- Find `utils.rs` file in `package_for_release` bin.
- In `ffmpeg_url()` function add `URL` to archive containing newly built FFmpeg release.

