#!/bin/sh

. ./architectures.sh

VERSION=$1
./get.sh $VERSION

for arch in $ARCHITECTURES; do
	dpkg-deb --build $arch
	mv "${arch%/}.deb" "/out/helm-${VERSION}-${arch%/}.deb"
done
