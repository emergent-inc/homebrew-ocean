class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.4/ocean-darwin-arm64.tar.gz"
      sha256 "abf2e605ab9e8941053408ee6d581af036a1f6779d7f370e02e653a49bedb6d7"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.4/ocean-darwin-x64.tar.gz"
      sha256 "b9a186ca3133189f091ab2a905622ac94476afeab3b96f5063e3fd7c18637a53"
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
      syncing, and mount the read-only team drive at ~/.ocean.
    EOS
  end

  test do
    assert_match "Ocean", shell_output("#{bin}/ocean --help")
  end
end
