#!/bin/bash

[ -z "$MONO_PREFIX" ] && export MONO_PREFIX=/opt/mono-sil

MONO_BIN=$DESTDIR$MONO_PREFIX/bin

# fix obsolete symlink
if [ -L $MONO_BIN/mono -a "$(readlink $MONO_BIN/mono)" = $MONO_BIN/mono-sil ]; then
    # make the symlink relative
    sudo ln -sf mono-sil $MONO_BIN/mono
fi

# fix obsolete wrapper
if [ -L $MONO_BIN/mono -a "$(readlink -f $MONO_BIN/mono)" = $MONO_BIN/mono-fw ]; then
    # make a new wrapper after the build
    sudo rm -f $MONO_BIN/mono-{fw,sil}
    [ -e $MONO_BIN/mono-real ] && sudo mv -f $MONO_BIN/mono{-real,}
fi

# don't try bootstrapping the shell script wrapper if the build fails
set -e

"$(dirname $0)"/build-and-install "$@"

# bootstrap the shell script wrapper as the mono that gets called (if needed)
if [ ! -f $MONO_BIN/mono-sil ]; then
    sudo cp -v "$(dirname $0)"/mono-sil $MONO_BIN/mono-sil
    [ -e $MONO_BIN/mono ] && sudo mv -v $MONO_BIN/mono{,-real}
    sudo ln -sf mono-sil $MONO_BIN/mono
fi

# show the user the current state of affairs (if everything succeeded)
ls -l $MONO_BIN/mono{,-sil,-real}
