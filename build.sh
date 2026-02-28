#!/usr/bin/env bash
set -e

echo "------------------------------------------------"
echo #
echo "Profile web service building script started"
echo #

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up environment..."
if test -d "$THIS_DIR/profile_data"; then
    echo "Pulling profile repository..."
    cd "$THIS_DIR/profile_data"
    git pull origin master
    cd "$THIS_DIR"
    echo "Pulling profile repository done."
else
    echo "ERROR: Missing profile repository at $THIS_DIR/profile_data"
    exit 1
fi

if test -d "$THIS_DIR/build"; then
    echo "Emptying old profile page build directory..."
    rm -rf "$THIS_DIR/build"
fi
mkdir -p "$THIS_DIR/build"
echo "Setting up environment done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Rebuilding global assets..."
if test -d "$THIS_DIR/../global_assets"; then
        cd "$THIS_DIR/../global_assets"
        ./build.sh
        cd "$THIS_DIR"
else
        echo "ERROR: Missing global assets directory at $THIS_DIR/../global_assets"
        exit 1
fi
echo "Rebuilding global assets done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Building profile page..."
FOOTER_FILE="$THIS_DIR/../global_assets/build/footer.html"
HEADER_FILE="$THIS_DIR/../global_assets/build/header.html"
STYLE_FILE="$THIS_DIR/../global_assets/build/style.html"
PROFILE_TEMPLATE_FILE="$THIS_DIR/../global_assets/templates/profile.html"

echo "Copying global logo and favicon..."
cp "$THIS_DIR/../global_assets/build/logo.png" "$THIS_DIR/build/logo.png"
cp "$THIS_DIR/../global_assets/build/favicon.png" "$THIS_DIR/build/favicon.png"
echo "Copying global logo and favicon done."
echo #

echo "Building profile page..."
pandoc -f gfm -t html --template="$PROFILE_TEMPLATE_FILE" --include-in-header="$STYLE_FILE" --include-before-body="$HEADER_FILE" --include-after-body="$FOOTER_FILE" -o "$THIS_DIR/build/profile.html" "$THIS_DIR/profile_data/README.md"
echo "Profile page built."
echo #

echo "Building profile page done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Profile web service building script finished"
echo "------------------------------------------------"
exit 0
