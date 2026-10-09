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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.1/tailscale-mcp-2.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "9af9fb91d898690c9800112381cc8b436b80679cbec9c089e356c872446c8d17"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.1/tailscale-mcp-2.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "f48e7a10b98a624ad708f5d40d17234c55673af543375c8e15a372a30595a5b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.1/tailscale-mcp-2.0.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "955e83ee2d1395aa664cd737696600793905ce650bf7a661a95fc43a1a16b93c"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.1/tailscale-mcp-2.0.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ede23b6e684c341f7474ac981c9496ee61ca32f56a47e2b4d3e5638137cd43f"
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
