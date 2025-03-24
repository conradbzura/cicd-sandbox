#!/bin/bash

USAGE="Usage: $0 major|minor [BRANCH=release]"

# Evaluate arguments
case $1 in
    major|minor)
        RELEASE_TYPE=$1
        ;;
    *)
        echo "ERROR: Invalid release type: $1" >&2
        echo $USAGE
        exit 1
        ;;
esac
case $# in
    1)
        BRANCH="release"
        ;;
    2)
        BRANCH=$2
        ;;
    *)
        echo $USAGE
        exit 1
        ;;
esac

git fetch --unshallow >/dev/null 2>&1
git checkout dev >/dev/null 2>&1
git pull >/dev/null 2>&1

# Check if the release branch already exists
if git show-ref --verify --quiet refs/heads/$BRANCH; then
    echo "ERROR: Branch '$BRANCH' already exists." >&2
    exit 1
fi

# Get the latest version tag, default to 0.0.0
VERSION=$(git describe --tags --abbrev=0)

# Verify no active release candidates exist
if [[ $VERSION == *rc* ]]; then
    echo "ERROR: An active release candidate already exists: $VERSION" >&2
    exit 1
fi

read MAJOR MINOR PATCH <<< $(scripts/split-version.sh $VERSION)

# Bump the version
case $RELEASE_TYPE in
    major)
        RELEASE_VERSION="$((MAJOR + 1)).0rc0"
        ;;
    minor)
        RELEASE_VERSION="${MAJOR}.$((MINOR + 1))rc0"
        ;;
esac

RELEASE_TAG="v$RELEASE_VERSION"

# Create a new branch for the release candidate
git checkout -b $BRANCH >/dev/null 2>&1
git push origin $BRANCH >/dev/null 2>&1

echo $RELEASE_TAG
