class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-ocean/releases/download/v0.2.0/ocean-darwin-arm64.tar.gz"
      sha256 "51c7ed2b0bcae1ef9369b325a1d07c2319e44feddf79b4b4bd26eadc534bd1b6"
    else
      url "https://github.com/emergent-inc/homebrew-ocean/releases/download/v0.2.0/ocean-darwin-x64.tar.gz"
      sha256 "7a57b5459811e96bc321225b5edb95b24b3b5a4a3d93fc3d52eb3ca4001765d1"
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
