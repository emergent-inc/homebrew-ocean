class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.5/ocean-darwin-arm64.tar.gz"
      sha256 "f0d7dcf845e32a037c990aedbdb607e472633e2aaebb387c98fd73fd224f9624"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.5/ocean-darwin-x64.tar.gz"
      sha256 "35661d2f1d92e25c333ea36e7024fd9de07de250b886cfb3975890f9354f203c"
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
