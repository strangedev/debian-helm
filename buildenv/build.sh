for arch in $(ls -d */); do
	dpkg-deb --build $arch
	mv "${arch%/}.deb" "/out/helm-${arch%/}.deb"
done
