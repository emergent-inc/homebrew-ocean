class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.1/ocean-darwin-arm64.tar.gz"
      sha256 "142f1b574d2348cec0559d2353de80628cd2c65513fadf440c349893e59d94d2"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.1/ocean-darwin-x64.tar.gz"
      sha256 "ce6a0de618dae1c134f8c0f23f506614056a076f3f22d10bc02db0d51eb7c616"
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
