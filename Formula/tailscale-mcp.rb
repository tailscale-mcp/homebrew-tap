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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.1.0/tailscale-mcp-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "8430b9c1412663ba527d9140a410b7dfbc7bf331c8a7dc99141c8faa20d5337b"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.1.0/tailscale-mcp-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0c494396cadfd29021d0690fad90477057a1a3883cc655ce8933418c26ed6e64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.1.0/tailscale-mcp-1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4654d7ba67a7bf1a8d40fa0bcf07d740db3c8b43806c26d0b8bef7f9ba194d24"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.1.0/tailscale-mcp-1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bdb9bcf86b5c905bbbb8c4bf4ff99b2d4060fa36fd3d44cedbb162b16f376406"
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
