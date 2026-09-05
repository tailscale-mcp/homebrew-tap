# tailscale-mcp tap

The Homebrew tap for [`tailscale-mcp`](https://github.com/tailscale-mcp/tailscale-mcp),
an MCP server for Tailscale backed by the `tailscale` command-line interface
and the control-plane REST API.

```sh
brew install tailscale-mcp/tap/tailscale-mcp
```

## What is here

One formula, `Formula/tailscale-mcp.rb`, which installs a release binary for
macOS and Linux on both architectures and verifies its checksum.

It is **generated, not written**: `release.yml` renders it from
`packaging/homebrew/tailscale-mcp.rb.in` in the main repository, checksums it
alongside the archives it points at, and attaches it to the GitHub release. The
copy here is that asset. Edit the template in the main repository rather than
this file, or the next release will overwrite the change.

## Updating this tap

Take `tailscale-mcp.rb` from the release being published and commit it here:

```sh
gh release download vX.Y.Z --repo tailscale-mcp/tailscale-mcp \
  --pattern tailscale-mcp.rb --output Formula/tailscale-mcp.rb
```

The formula carries no `version` field — Homebrew reads the version from the
archive name, and `brew audit` refuses a formula that states it twice.
