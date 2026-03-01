# Profile (profile.xqhare.net)

## Project Overview
This directory contains the source content and configuration for `profile.xqhare.net`.

## Directory Structure
- `profile_data/`: A git repository containing detailed profile information (Markdown).
- `build/`: Temporary directory for generated HTML files.
- `data/`: Stores timestamped deployments for atomic updates and rollbacks.
- `html/`: The live directory served by Nginx, containing symlinks to `data/`.
- `build.sh`: Pulls the latest `profile_data`, pulls `global_assets`, and compiles the profile content into static HTML using `pandoc`.
- `deploy.sh`: Handles atomic deployment using timestamped directories and symlinks.
- `rollback.sh`: Reverts the active symlinks to the previous deployment state.
- `hook.sh`: Triggered after a git push to rebuild and redeploy the profile site.
- `README.md`: High-level overview of the profile site.

## Usage
Content is derived from the `profile_data` repository. The `build.sh` script converts this data into static HTML for `profile.xqhare.net`. Deployed automatically and atomically.
