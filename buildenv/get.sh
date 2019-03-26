#!/bin/sh

. ./architectures.sh
ARTEFACT_REPO_URL="https://storage.googleapis.com/kubernetes-helm"

get_release_url()
{
	version=$1
	architecture=$(get_helm_architecture_name $2)

	echo "${ARTEFACT_REPO_URL}/helm-v${version}-linux-${architecture}.tar.gz"
}

get_helm_architecture_name()
{
	# upstream drops the i in i386 for some reason
	# case used here in case this worsens in the future
	case $1 in
		"i386" )
			echo "386"
			;;
		* )
			echo "$1"
			;;
	esac
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

	curl $(get_release_url "$VERSION" "$architecture") \
		| tar -xz \
		-C "./${architecture}/usr/local/bin/" \
		"linux-$(get_helm_architecture_name $architecture)/helm" --strip-components=1
done
