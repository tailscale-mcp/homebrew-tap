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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.3/tailscale-mcp-1.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "8b7cd1c5e3fc2186d21a7cf412a1c17e73e0357efacc454d75456c5ba0a5e7ee"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.3/tailscale-mcp-1.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "91379ebed6354f74a7ab164828a8086c0686ac1a19cda26cdd58a93f367547e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.3/tailscale-mcp-1.0.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "17636a4eadbf30b78e95acbdb8cc069d31ffc926882dc6bd8ad4d74e4d75cb20"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.0.3/tailscale-mcp-1.0.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6063a66647350c57fc0bfe92c34680636887bb2905a988068c594b4e353f344d"
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
