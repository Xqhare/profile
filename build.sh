#!/usr/bin/env bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "------------------------------------------------"
echo #
echo "Profile web service building script started"
echo #
echo "Setting up environment"
echo #
echo "Setting up profile repo"
if test -d "$THIS_DIR/profile_data"; then
    echo #
    echo "Pulling profile repo"
    cd "$THIS_DIR/profile_data"
    git pull origin master
    cd "$THIS_DIR"
    echo #
    echo "Pulling profile repo done"
else
    echo "ERROR: Missing profile repo at $THIS_DIR/profile_data"
    exit 1
fi

echo #

if test -d "$THIS_DIR/build"; then
    echo "Emptying old profile page build directory"
    rm -rf "$THIS_DIR/build"
fi
mkdir -p "$THIS_DIR/build"

echo #
echo "Setting up environment done"
echo #
echo "Rebuild global assets"

if test -d "$THIS_DIR/../global_assets"; then
        cd "$THIS_DIR/../global_assets"
        ./build.sh
        cd "$THIS_DIR"
else
        echo "Missing global assets directory at $THIS_DIR/../global_assets"
        exit 1
fi

echo #
echo "Rebuilding global assets done"
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Building profile page"

FOOTER_FILE="$THIS_DIR/../global_assets/build/footer.html"
HEADER_FILE="$THIS_DIR/../global_assets/build/header.html"
STYLE_FILE="$THIS_DIR/../global_assets/build/style.html"
PROFILE_TEMPLATE_FILE="$THIS_DIR/../global_assets/templates/profile.html"

echo "Copying global logo and favicon"

cp "$THIS_DIR/../global_assets/build/logo.png" "$THIS_DIR/build/logo.png"
cp "$THIS_DIR/../global_assets/build/favicon.png" "$THIS_DIR/build/favicon.png"

echo "Copying global logo and favicon done"
echo #

echo "Building profile page"

pandoc -f gfm -t html --template="$PROFILE_TEMPLATE_FILE" --include-in-header="$STYLE_FILE" --include-before-body="$HEADER_FILE" --include-after-body="$FOOTER_FILE" -o "$THIS_DIR/build/profile.html" "$THIS_DIR/profile_data/profile.md"

echo "Profile page built"
echo #
echo "Building profile page done"
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Building script done"
exit 0
