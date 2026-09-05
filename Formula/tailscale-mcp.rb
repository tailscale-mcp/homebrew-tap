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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.1/tailscale-mcp-1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "9e475ab104f648aa33570f3b617adcd4564f7635f7007196bd52a2cfee383434"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.1/tailscale-mcp-1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "1dc5b9ea5875ef140fd051723b0c35c32e0fa433bf330593e5d15f86254ffa9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.1/tailscale-mcp-1.0.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eec19e781758db99f2afa44dc899c4e2049dac03379ce81db847e4e8ea8b770b"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.1/tailscale-mcp-1.0.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1d8165877b3f6d44bd7016f971a90672ae854269238524196990c8161a5ee44"
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
