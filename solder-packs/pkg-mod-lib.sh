#! /bin/bash
# This is a bash script sourced by pkg-mod.sh

AUTHORS=unknown
URL=unknown

function finalize () {
    local slug=${1:?Must specify slug in $@}
    local version=${2:?Must specify version in $@}

    if [ ! -f "$p/$slug/$slug-$version.zip" ]; then
	echo "Unable to locate $p/$slug/$slug-$version.zip in finalize" >&2
	exit 1
    fi

    ~/tz/bin/ziptorrent -v "$p/$slug/$slug-$version.zip"
    local sum=$(md5sum "$p/$slug/$slug-$version.zip" |cut -d\  -f1)
    cat >>"$p/mod.sql" <<EOF
INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('$slug', '$slug', '$slug', '$AUTHORS',
	  '$URL', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='$AUTHORS',
    link='$URL';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '$version', '$sum', now(), now()
  FROM solder_mods
  WHERE name='$slug'
  ON DUPLICATE KEY UPDATE
    md5='$sum',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='$slug'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='$version'
    AND solder_builds.version='$MPVERSION'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='$MPSLUG')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

EOF
    sjdone=$(( $sjdone + 1 ))
    echo $(( 100 * $sjdone / $sjtotal )): $sjdone / $sjtotal: $slug
}

function stagezipdata () {
    local source=${1:?Must specify source zip file}

    if [ ! -f "$s/$source" ]; then
	echo "Unable to locate $source" >&2
	exit 1
    fi

    rm -rf "$st"
    mkdir -p "$st"
    (cd "$st" \
	&& unzip "../$s/$source")
}

function solderfile () {
    local staged=0
    local clientonly=0
    local serveronly=0
    if [ "$1" = "--staged" ]; then
	staged=1
	shift
    fi
    if [ "$1" = "--client" ]; then
	clientonly=1
	shift
    fi
    if [ "$1" = "--server" ]; then
	serveronly=1
	shift
    fi

    local source=${1:?Must specify source in $@}
    local slug=${2:?Must specify slug in $@}
    local version=${3:?Must specify version in $@}
    local dsub=${4:-mods}
    local dest=${5:-$source}

    local origin=$s
    if [ $staged -ne 0 ]; then
	origin=$st
    fi

    if [ ! -r "$origin/$source" ]; then
	echo "Unable to locate $source" >&2
	exit 1
    fi

    if [ $serveronly -eq 1 ]; then
	mkdir -p "$sv/$dsub"
	cp -rp "$origin/$source" "$sv/$dsub/$dest"
	sjdone=$(( $sjdone + 1 ))
	echo $(( 100 * $sjdone / $sjtotal )): $sjdone / $sjtotal ...server package for $slug

    else
	rm -rf "$u/$slug-$version"
	mkdir -p "$u/$slug-$version/$dsub"
	if [ -d "$origin/$source" ]; then
	    cp -r "$origin/$source" "$u/$slug-$version/$dsub/$dest"
	else
	    cp "$origin/$source" "$u/$slug-$version/$dsub/$dest"
	fi
	mkdir -p "$p/$slug"
	(cd "$u/$slug-$version" \
		&& zip -rDXoq "../../$p/$slug/$slug-$version.zip" "$dsub" )
	if [ $clientonly -eq 0 ]; then
	    mkdir -p "$sv/$dsub"
	    cp -rp "$origin/$source" "$sv/$dsub/$dest"
	fi

	finalize "$slug" "$version"
    fi
}

function gitfile () {
    local clientonly=0
    local repo=${1:?Must specify repo URL in $@}
    local slug=${2:?Must specify slug in $@}
    local version=${3:?Must specify version in $@}
    if [ "$1" = "--client" ]; then
	clientonly=1
	shift
    fi

    mkdir -p "$p/$slug"
    git archive --remote="$repo" --format=zip \
	-o "$p/$slug/$slug-$version.zip" HEAD
    if [ $clientonly -eq 0 ]; then
	mkdir -p "$sv"
	( cd "$sv"; unzip "../$p/$slug/$slug-$version.zip" )
    fi

    finalize "$slug" "$version"
}

function stagegitfile () {
    local repo=${1:?Must specify repo URL in $@}
    local slug=${2:?Must specify slug in $@}
    local version=${3:?Must specify version in $@}

    rm -rf "$st"
    mkdir -p "$st"
    git archive --remote="$repo" --format=zip \
	-o "$st/$slug.zip" HEAD
}

function setauthors () {
    AUTHORS="$@"
}

function seturl () {
    URL="$@"
}

function reset_auth () {
    AUTHORS=unknown
    URL=unknown
}
