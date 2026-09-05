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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.4/tailscale-mcp-1.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "066d4d7c4b87ef3cd2e8840a10526dd7a5ce44517caaaaf53dcadc35f47c78a9"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.4/tailscale-mcp-1.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "c9c99250170f19c2a8aa168bcf241718092d05ec1962bf2ed32ba34b1a4c6948"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.4/tailscale-mcp-1.0.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b553100343a685116f899eebd33c46d2bb6e62eb5ad72cffab7d490b659bd7aa"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.4/tailscale-mcp-1.0.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5334cface2b08597c51c67181524c538267f7fb16731bd95865d973dcce8485f"
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
