#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Deploying profile service script started"
echo #
echo "Setting up environment"

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

echo "Setting up environment done"
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Deploying profile page"
echo #

NEW_PROFILE_FILE="$DEPLOYMENT_DIR/profile.html"

echo "Move build data to data directory"

mv "$BUILD_DIR/profile.html" "$NEW_PROFILE_FILE"

echo "Moving done"
echo #
echo "Updating favicon and logo"

cp "$BUILD_DIR/favicon.png" "$THIS_DIR/html/favicon.png"
cp "$BUILD_DIR/logo.png" "$THIS_DIR/html/logo.png"

echo "Updating favicon and logo done"
echo #
echo "Creating symlinks"

cd "$THIS_DIR/html"
ln -s -f "../data/$(basename "$DEPLOYMENT_DIR")/profile.html" "index.html"

echo "Symlinks created"
echo #
echo "Deploying profile page done"
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #
echo "Deploying script done"
echo "------------------------------------------------"
exit 0
