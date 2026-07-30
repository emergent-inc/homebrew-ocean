class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.1/ocean-darwin-arm64.tar.gz"
      sha256 "70515b1f17bf6c04cfdc9dd04e2303876377a1bc6d1361731b5f96b59486986c"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.1/ocean-darwin-x64.tar.gz"
      sha256 "dcaf2b63528b50f3a621a8bfc864420b42ee3e6027fe40407a63d202bc750551"
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
