# README

This repo contains various scripts as well as packaging info for our custom mono version.

The script `repackage-msbuild` will repackage `msbuild` packages from mono-project.com so that the
binaries are installed in `/opt/mono5-sil`. This is necessary in order to build and run unit tests
with `mono5-sil`.