#!/bin/bash
[ -z "$MONO_PREFIX" ] && export MONO_PREFIX=/opt/mono-sil
# don't try bootstrapping the shell script wrapper if the build fails
set -e
"$(dirname $0)"/build-and-install "$@"
# bootstrap the shell script wrapper as the mono that gets called (if needed)
if [ ! -f $MONO_PREFIX/bin/mono-real ]; then
    sudo /bin/mv -v $MONO_PREFIX/bin/mono $MONO_PREFIX/bin/mono-real
    sudo /bin/cp -v "$(dirname $0)"/mono-sil $MONO_PREFIX/bin/mono-sil
    sudo /bin/chmod +x $MONO_PREFIX/bin/mono-sil
    sudo /bin/ln -s $MONO_PREFIX/bin/mono{-sil,}
fi
# show the user the current state of affairs (if everything succeeded)
/bin/ls -l $MONO_PREFIX/bin/mono{,-fw,-real,-sil}
