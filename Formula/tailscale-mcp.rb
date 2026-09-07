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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.1/tailscale-mcp-1.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "3dbc576589ab2dfe2b61594a51ab944dbf5915a8b20cca0ae0ca5a013fad5f57"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.1/tailscale-mcp-1.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "7819543c9713292f594ee84ce42dfe0fd8e7d5338d84bf625ce8dfadc755c7d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.1/tailscale-mcp-1.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0d02464c5d52f993cf30215f610b24a2d4ee4a7cddcf1b76fd65b574ec1761f"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.3.1/tailscale-mcp-1.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d2bfccc97f33ed8fced6eff68762b681f8c375295aec9438866a364ef97979cc"
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
