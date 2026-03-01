#!/usr/bin/env bash
set -e

echo "------------------------------------------------"
echo #
echo "Deploying profile web service script started"
echo #

echo "Setting up environment..."
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$THIS_DIR"

if ! test -d "$THIS_DIR/html"; then
        mkdir -p "$THIS_DIR/html"
fi

# Deploy assumes that any building has already been done
BUILD_DIR="$THIS_DIR/build"
DATA_DIR="$THIS_DIR/data"
if ! test -d "$DATA_DIR"; then
        mkdir -p "$DATA_DIR"
fi

DEPLOYMENT_DIR="$DATA_DIR/$(date +%Y-%m-%d-%H-%M-%S)"
mkdir -p "$DEPLOYMENT_DIR"
echo "Setting up environment done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Deploying profile page..."
NEW_PROFILE_FILE="$DEPLOYMENT_DIR/profile.html"

echo "Moving build data to data directory..."
mv "$BUILD_DIR/profile.html" "$NEW_PROFILE_FILE"
cp "$BUILD_DIR/favicon.png" "$DEPLOYMENT_DIR/favicon.png"
cp "$BUILD_DIR/logo.png" "$DEPLOYMENT_DIR/logo.png"
echo "Moving done."
echo #

echo "Creating symlinks..."
cd "$THIS_DIR/html"
# Robust replacement: remove before symlinking
rm -f "index.html" "favicon.png" "logo.png"
ln -s -f "/usr/share/nginx/data/$(basename "$DEPLOYMENT_DIR")/profile.html" "index.html"
ln -s -f "/usr/share/nginx/data/$(basename "$DEPLOYMENT_DIR")/favicon.png" "favicon.png"
ln -s -f "/usr/share/nginx/data/$(basename "$DEPLOYMENT_DIR")/logo.png" "logo.png"
echo "Symlinks created."
echo #

echo "Deploying profile page done."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Deploying profile web service script finished"
echo "------------------------------------------------"
exit 0
