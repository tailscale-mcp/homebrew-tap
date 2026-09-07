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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.0/tailscale-mcp-1.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "cfadf8486f8029388b8f4ec2e48926005d26a71740d1f4f56e3c12b88f3a36eb"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.0/tailscale-mcp-1.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "b6f53ef9e4cb15fb0b036b8871d66da6d6a640baacbf754bcc43b4e8d020ec8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.0/tailscale-mcp-1.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ef0baa0d9126555b367d473a98eb0768f1cd92470ba31028756c6f537cf1ffde"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.0/tailscale-mcp-1.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d64761c26d331cdf2435f188527a629b2cdf588dc8b60db7b53393214c3e9dba"
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
