#!/bin/sh

. ./architectures.sh
ARTEFACT_REPO_URL="https://storage.googleapis.com/kubernetes-helm"

get_release_url()
{
	version=$1
	architecture=$2
	echo "${ARTEFACT_REPO_URL}/helm-v${version}-linux-${architecture}.tar.gz"
}

VERSION=$1

if [ -z $VERSION ]; then
	echo "No version specified, aborting."
	exit 1
fi

for architecture in $ARCHITECTURES; do
	cp -r TEMPLATE "./${architecture}"

	versionEscaped=$(echo "$VERSION" | sed "s/\./\\\./g")
	sed -i "s/{{VERSION}}/${versionEscaped}/g" "${architecture}/DEBIAN/control"
	sed -i "s/{{ARCHITECTURE}}/${architecture}/g" "${architecture}/DEBIAN/control"

	echo $(get_release_url "$VERSION" "$architecture")
	curl $(get_release_url "$VERSION" "$architecture") \
		-o "./${architecture}/usr/local/bin/helm"
done
