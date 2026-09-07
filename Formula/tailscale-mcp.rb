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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.2/tailscale-mcp-1.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "8d1219225121efa781a1793c45451883644539888b56c170d32637aee7cc3739"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.2/tailscale-mcp-1.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "2ef1ee63c75a1b8d6a599de2b093af99cd00f901b9d880fb09118ea9d5d9b8d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.2/tailscale-mcp-1.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d3cbc72e7d4330e33e333b9404b9d5915d6af6a6ae5bf566d33ec1b6b7f07b42"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v1.2.2/tailscale-mcp-1.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a976f4ba166702418a264ce61fda9f03b1729ced2995ead3d42e2e911b6052b2"
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
