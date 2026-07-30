class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.0/ocean-darwin-arm64.tar.gz"
      sha256 "7c65d23aaf5744fe52f6ddfcd4f4e1ed9272ee2c1d7224b5c6fb48aac38e9614"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.0/ocean-darwin-x64.tar.gz"
      sha256 "5b790f7785679e8ade90a8d4394007da567e146e5eae406162f82a987da76de8"
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
