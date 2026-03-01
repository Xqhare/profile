# Profile

The profile page service for `xqhare.net`.

This service renders a GitHub-style profile page using content pulled from a dedicated `profile_data` repository.

## Workflow

Unlike other services, the `Profile` build script automatically pulls the latest content from the `profile_data` repository before rendering. This allows the profile content to be updated independently of the web service infrastructure.

## Structure

- `profile_data/`: Git submodule/repository containing the actual profile Markdown (README.md).
- `build.sh`: Pulls profile data, pulls global assets, and renders the profile HTML.
- `deploy.sh`: Deploys the rendered profile to the production environment.
- `rollback.sh`: Reverts the profile page to the previous version.

For the network-wide architecture, [see here](https://github.com/xqhare/xqhare.net/).
