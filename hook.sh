#!/usr/bin/env bash

echo "------------------------------------------------"
echo #
echo "Profile web service hook script started"

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$THIS_DIR"

if ./build.sh; then
        ./deploy.sh
        cd "$THIS_DIR/.."
        ./cleanup_data.sh
else
        echo "ERROR: Building failed; not deploying."
        echo "------------------------------------------------"
        exit 1
fi

echo "Profile web service hook script finished"
echo "------------------------------------------------"
echo #
exit 0
