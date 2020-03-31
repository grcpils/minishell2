#!/usr/bin/env bash
#
# @Author: gouerec_p
# @Date:   2020-03-10 18:49:50
# @Last Modified by:   gouerec_p
# @Last Modified time: 2020-03-10 18:50:08
# 
URL="https://github.com/Snaipe/Criterion/releases/download/v2.3.2"
TARBALL="criterion-v2.3.2-linux-x86_64.tar.bz2"
DIR="criterion-v2.3.2"
DST="/usr/local/"
SUDO=/usr/bin/sudo

if [ $UID -eq "0" ]; then
    SUDO=""
    echo "[no sudo for root]"
fi

cd /tmp
rm -f $TARBALL
rm -fr $DIR

wget $URL/$TARBALL
if [ $? != 0 ]; then
    echo "failled, exiting"
    exit;
fi

echo
echo "untaring $TARBALL"
tar xjf $TARBALL
if [ $? != 0 ]; then
    echo "failled, exiting"
    exit;
fi

echo "creating custom ld.conf"
$SUDO sh -c "echo "/usr/local/lib" > /etc/ld.so.conf.d/criterion.conf"
echo "cp headers to $DST/include..."
$SUDO cp -r $DIR/include/* $DST/include/
echo "cp lib to $DST/include..."
$SUDO cp -r $DIR/lib/* $DST/lib/
echo "run ldconfig."
$SUDO ldconfig
echo "all good."