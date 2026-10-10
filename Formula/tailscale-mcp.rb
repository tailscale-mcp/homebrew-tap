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
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.2/tailscale-mcp-2.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "8e70c14f508b25248fccad5d78762fd93f81dd827c1e0c13d27ee24de5325c96"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.2/tailscale-mcp-2.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "72940ddb99dbedcc0f136f1bbc504a536bbdc91411ddf139527fab971332392a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.2/tailscale-mcp-2.0.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bf425791210f1f663ba394ff0c3add1b510773692544872580e76655e1151e96"
    end
    on_intel do
      url "https://github.com/tailscale-mcp/tailscale-mcp/releases/download/v2.0.2/tailscale-mcp-2.0.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b1f081da9204b0fa3e86871754ee7c7954c90f5cd133120452d53df36774da13"
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
