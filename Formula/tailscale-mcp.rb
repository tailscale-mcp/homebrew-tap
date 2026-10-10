# Rendered from packaging/homebrew/tailscale-mcp.rb.in by
# scripts/update-formula.sh. Edit the template, not this.
class TailscaleMcp < Formula
  desc "MCP server for Tailscale, over the CLI and the control-plane API"
  homepage "https://github.com/tailscale-mcp/tailscale-mcp"
  license "Apache-2.0"
  # No `version`: Homebrew reads it from the archive name, and `brew audit`
  # refuses a formula that says it twice.

  on_macos do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.3/tailscale-mcp-2.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "7cde2b97d8df580e6484250d14c16041ab4c2d842f620485cdb0502c878cce10"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.3/tailscale-mcp-2.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "8f78a3d64829f799c7a520acaeb4d49bdb5c295e72bcc8eff2f4a64a5efd3f44"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.3/tailscale-mcp-2.0.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1fcba8aa67f5c882ddf438ab179bd0d5e308232feba260527b30b3b2e7b1290a"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.3/tailscale-mcp-2.0.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "199ef95206aa0d63f526fa0ce030a4a51784279a2be9298227f754f9760a2efe"
    end
  end

  def install
    bin.install "tailscale-mcp"
  end

  def caveats
    <<~EOS
      The tools that drive this node need the `tailscale` command-line
      interface installed; the tools that drive the tailnet need a
      control-plane credential in TAILSCALE_API_KEY, or in
      TAILSCALE_OAUTH_CLIENT_ID and TAILSCALE_OAUTH_CLIENT_SECRET. Whichever
      is missing, its tools are not offered rather than failing when called;
      `tailscale-mcp diagnose` says which of the two this machine has.

      For a configuration snippet for your MCP client:
        tailscale-mcp setup claude-code
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tailscale-mcp version")
    # Nothing is configured under `brew test`, so this is the answer a machine
    # with neither backend gives: the read-only tools, and no failure.
    assert_match "preset core", shell_output("#{bin}/tailscale-mcp tools")
  end
end
