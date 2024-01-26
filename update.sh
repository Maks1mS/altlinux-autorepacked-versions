#!/bin/sh

DIRNAME=$( dirname -- "$( readlink -f -- "$0"; )"; )

find scripts -type f -name "*.sh" | while read file; do
    TMP=$(mktemp -d)
    cd $TMP
    $DIRNAME/$file
    VERSION=$(rpm -qp --queryformat '%{VERSION}' *.rpm)
    t=$(basename $DIRNAME/$file)
    PKG=${t%.*}
    mkdir -p $DIRNAME/data/$PKG
    echo -n $VERSION > $DIRNAME/data/$PKG/version.txt
    rm -r $TMP
done