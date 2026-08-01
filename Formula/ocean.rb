class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.8/ocean-darwin-arm64.tar.gz"
      sha256 "6e5ad97b1c5aba252346cdc81dbf084f16a9b4d2d992461686ad070732a059e9"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.8/ocean-darwin-x64.tar.gz"
      sha256 "ba1d58fe76baf96f6299eb9ca925b1cdc75817d44bd469d0ef67e51157faad3e"
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
