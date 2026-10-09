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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.0/tailscale-mcp-2.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "8c71fc2cf60681d13c21dedcf9daa1ce0149a349552ca354198dde47815527b6"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.0/tailscale-mcp-2.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "3152b3c39360397dd98cd1e587712df00ae7e87c7a7f571f27d4b6997d3e9f40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.0/tailscale-mcp-2.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "20c8f96f1aa9ed183ec37606be16fc1e4ecf30400f6b488921023fa878f9a982"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.0/tailscale-mcp-2.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1991cd739a05a16b83d7fa1c1ac4a5f9eb616a5a69e20d62ec4bac2833ef0b12"
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
