class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.6/ocean-darwin-arm64.tar.gz"
      sha256 "30536c6e173004f727dae0cabcb88d17f7380305b1032268ea3e9a63cfad45b9"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.6/ocean-darwin-x64.tar.gz"
      sha256 "1aa467d9bfbbe782745a83f6bde8669a1ec2f85a035495053ddb67d0a320be8e"
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
