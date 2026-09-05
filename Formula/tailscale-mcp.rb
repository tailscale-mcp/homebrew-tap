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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.2/tailscale-mcp-1.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "2ced53caee4771ea6053803ea1f3e490e77bdca411803304642b7d16144248c2"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.2/tailscale-mcp-1.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "c2740b4d3c7b38464bfb2aa06f61e74c3a2f9fa569385c77b3812f1cb6ddccf5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.2/tailscale-mcp-1.0.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3281b74b46ab230d0315626dee357f922cd786501d419f6bec564b7041374188"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.2/tailscale-mcp-1.0.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c0feea7e1ba6e83e526aacaacad1e75288d850c97b87d173d111a72d64729c3f"
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
