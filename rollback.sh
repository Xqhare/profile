#!/usr/bin/env bash

# rollback.sh for profile service
# Reverts the index.html symlinks to the second latest version in the data directory.

echo "------------------------------------------------"
echo #
echo "Rolling back profile web service script started"
echo #

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR="$THIS_DIR/data"
HTML_DIR="$THIS_DIR/html"

if [ ! -d "$DATA_DIR" ]; then
    echo "ERROR: No data directory found for profile service."
    echo "------------------------------------------------"
    exit 1
fi

# Get the second latest entry (the one before the current one)
PREVIOUS_VERSION=$(ls -1 "$DATA_DIR" | sort -r | sed -n '2p')

if [ -z "$PREVIOUS_VERSION" ]; then
    echo "ERROR: No previous version found to roll back to for profile service."
    echo "------------------------------------------------"
    exit 1
fi

echo "Rolling back profile service to version: $PREVIOUS_VERSION..."

# Update profile page symlink
cd "$HTML_DIR"
ln -s -f "../data/$PREVIOUS_VERSION/profile.html" "index.html"

echo "Rollback for profile service complete."
echo "- - - - - - - - - - - - - - - - - - - - - - - -"
echo #

echo "Rolling back profile web service script finished"
echo "------------------------------------------------"
exit 0
