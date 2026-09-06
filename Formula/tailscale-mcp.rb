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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.0/tailscale-mcp-1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "de4c9bd9ea57de8459f54ccb2189c5561aa33e3aad9a439b01cb8dafef4f9bd7"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.0/tailscale-mcp-1.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "e8438fb439ba768c88027989bfbcf226cd124b85aa88b58863513aca12e856bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.0/tailscale-mcp-1.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bcc6d17f7a48f1e11e77fe31e7641b9a2a46302b1e3d9eb13109cec223a35ba3"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.0/tailscale-mcp-1.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c21a17c8611dc2b402df83dc080050778e32d1e039c3f17610444cdfd596460"
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
