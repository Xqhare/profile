# Profile (profile.xqhare.net)

## Project Overview
This directory contains the source content and configuration for `profile.xqhare.net`.

## Directory Structure
- `profile_data/`: A symlink to the `Xqhare/` repository, containing detailed profile information.
- `build.sh`: Intended to compile the profile content into static HTML.
- `deploy.sh`: (Placeholder) Intended to deploy the generated HTML to the server.
- `hook.sh`: Triggered after a git push to rebuild and redeploy the profile site.
- `README.md`: High-level overview of the profile site.
- `LICENSE`: MIT License.

## Usage
Content is derived from the `profile_data` symlink. The `build.sh` script is planned to convert this data into static HTML for `profile.xqhare.net`. Deployed automatically via the `webpage` pipeline. Refer to [../webpage_startup_notes/GEMINI.md](../webpage_startup_notes/GEMINI.md) for technical details on the build and deployment process.
