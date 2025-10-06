# GitHub Actions Version Update Summary

This document summarizes the GitHub Actions version updates made to the workflow files in this repository.

## Updated Actions

### 1. actions/checkout: v4 → v5
- **Previous versions**: v4.2.2, v4
- **New version**: v5
- **Breaking changes**:
  - Requires GitHub Actions Runner v2.327.1 or newer
  - Updated to use Node 24
- **Impact**: Minimal - GitHub-hosted runners already meet the minimum runner version requirement

### 2. oxsecurity/megalinter: v7 → v9
- **Previous version**: v7
- **New version**: v9
- **Breaking changes**:
  - **Disabled linters** (until upstream issues are fixed):
    - `puppet-lint`: Disabled until fix for https://github.com/puppetlabs/puppet-lint/issues/251
    - `checkov`: Disabled until fix for https://github.com/bridgecrewio/checkov/issues/7263
  - **Removed linters**:
    - `markdown-link-check`: Removed (can use `lychee` as replacement)
  - Base image updated to `python:3.13-alpine3.21`
  - Uses `uv` to create venv folder for pip-installed linters
- **Impact**: Low - This repo doesn't appear to use Puppet or Terraform (checkov), and the other changes are internal improvements

### 3. actions/upload-artifact: v3 → v4
- **Previous version**: v3
- **New version**: v4
- **Breaking changes**:
  - **Hidden files are no longer included by default** (v4.4.0+)
    - Can be re-enabled with `include-hidden-files: true` if needed
  - Updated to use Node 20 (requires Actions Runner v2.308.0+)
- **Impact**: Low - The MegaLinter artifacts being uploaded likely don't include hidden files

### 4. softprops/action-gh-release: v2 → v2 (patch update)
- **Previous version**: v2
- **New version**: v2 (now using latest v2.3.4)
- **No breaking changes**: Staying on v2 major version, only patch/minor updates

### 5. sersoft-gmbh/running-release-tags-action: v3 (already up to date)
- **Version**: v3
- **Status**: Already on latest major version (v3.0.0)
- **No action needed**

## Testing Recommendations

1. **Verify runner compatibility**: The workflow should work fine on GitHub-hosted runners which are regularly updated.

2. **MegaLinter changes**: The v9 update brings many improvements but removes some linters. Since this repo appears to be primarily shell scripts and configuration files, the removed linters (Puppet, markdown-link-check) shouldn't affect the build.

3. **Upload artifact behavior**: If you notice that certain files are no longer being uploaded in the MegaLinter artifacts, you can add `include-hidden-files: true` to the upload-artifact step.

## References

- [actions/checkout v5 release notes](https://github.com/actions/checkout/releases/tag/v5.0.0)
- [oxsecurity/megalinter v9 release notes](https://github.com/oxsecurity/megalinter/releases/tag/v9.0.0)
- [actions/upload-artifact v4 release notes](https://github.com/actions/upload-artifact/releases/tag/v4.4.0)
- [softprops/action-gh-release releases](https://github.com/softprops/action-gh-release/releases)
