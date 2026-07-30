class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.2/ocean-darwin-arm64.tar.gz"
      sha256 "4a1e6272af98b67ae95586de19c2cc638666300ed1f04e6fc8041db72b28befa"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.2/ocean-darwin-x64.tar.gz"
      sha256 "f265c1e1c5501a2e233196dfb15ff8f4ea02b69dc550c8b6b1783c66c69d24f1"
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
