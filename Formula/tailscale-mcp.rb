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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.2/tailscale-mcp-1.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "b5702300e129a4ad6f6aeb2bb822cfc70b61fa6e2bd71d66679be47886e00326"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.2/tailscale-mcp-1.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "79c8c9b2d1e2cae853f6bd08fc6efe7a894d46b57257f8cf07fd732257592d18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.2/tailscale-mcp-1.3.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e32054c5cb9dd24c799027dfb16edb86e1463f8c82440d400eaed58c161a7f89"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.2/tailscale-mcp-1.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4dd9d7e65e862ea8225adc5b60a3d1749a58fb5ca7c97bd2c604f5022a712f52"
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
