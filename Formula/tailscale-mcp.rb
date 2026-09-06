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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.1/tailscale-mcp-1.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "b969f5224fe19aba81eee1d1c3c9aac02e82c3627236f553bf9625bcc373b32c"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.1/tailscale-mcp-1.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "71d1af2ab6081053104e56d135e3dc6c1ceece16e276363b6e9ab2242661e9ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.1/tailscale-mcp-1.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "abd9c27c70cc132443197e3db6f7acfd530e74b166174af7c743d38998d33ff6"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.1/tailscale-mcp-1.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18c3c5df66d238a06a55d81daa9f1dbd4ebbdca397690b98617e6577774822ec"
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
