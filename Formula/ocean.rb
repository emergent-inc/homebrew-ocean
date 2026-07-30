class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-ocean/releases/download/v0.2.0/ocean-darwin-arm64.tar.gz"
      sha256 "1947766ad4c6ad494aca135f37ea22390d7c7c116786f5b56521279b1c74ade2"
    else
      url "https://github.com/emergent-inc/homebrew-ocean/releases/download/v0.2.0/ocean-darwin-x64.tar.gz"
      sha256 "5b827694db1e5f50cad1003e9d66be662f4acfbf6ee52c9774a385e554cd0c79"
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
      syncing, and mount the read-only team drive at /Volumes/Ocean.
    EOS
  end

  test do
    assert_match "Ocean", shell_output("#{bin}/ocean --help")
  end
end
