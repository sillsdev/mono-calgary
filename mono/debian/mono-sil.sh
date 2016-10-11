#!/bin/bash
#
# Original author: MarkS 2010-06-03
# Modified for generalized use by WeSay and other projects: SteveMc 2014-01-10
#
# Set up environment for running the SIL version of mono. Suitable for use by
# monodevelop.
#
# Example Installation:
#  cd /opt/mono-sil/bin
#  sudo ln -sf mono-sil mono
#
# Example Usage (possibly in shell scripts to run individual programs):
#  export MONO_ENVIRON=/path/to/LSDev/environ/script
#  BUILD=Release /opt/mono-sil/bin/mono WeSay.exe
#
#  See http://linux.lsdev.sil.org/wiki/index.php/Install_and_use_Monodevelop
#  for more information.

if [ -n "$MONO_ENVIRON" -a -f "$MONO_ENVIRON" ]; then
  pushd "$(dirname "$MONO_ENVIRON")" >/dev/null
  source "$MONO_ENVIRON"
  popd >/dev/null
fi
exec "$(dirname "$0")/mono-sgen" "$@"
