class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.7/ocean-darwin-arm64.tar.gz"
      sha256 "80ede2685188fd5d054c2ba402b5c1e4ade4f3437719efb1f64341200ae43385"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.7/ocean-darwin-x64.tar.gz"
      sha256 "2060d2f90e7fb5930298bf7cf46b7a190089a6df29afbccbb311613821eec828"
    end
  end

  def install
    libexec.install "ocean", "orgtrace", "rclone"
    libexec.install "node", "ocean.mjs" if File.exist?("node")
    bin.install_symlink libexec/"ocean"
    bin.install_symlink libexec/"orgtrace"
  end

  def caveats
    <<~EOS
      Run `ocean install` to authenticate, select a team, start continuous
      syncing, mount the read-only team drive at ~/.ocean, and install Ocean
      guidance for supported coding agents.
    EOS
  end

  test do
    assert_match "Ocean", shell_output("#{bin}/ocean --help")
  end
end
