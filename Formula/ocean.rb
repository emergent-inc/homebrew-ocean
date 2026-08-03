class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.15/ocean-darwin-arm64.tar.gz"
      sha256 "a08406beda6bb26cca76ee11c6e202367f302c52df1929c753f3ad5785162412"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.15/ocean-darwin-x64.tar.gz"
      sha256 "829d2500835090a6fd06663918b45e87bc58c56fea0ac1a773802675f264f49a"
    end
  end

  def install
    libexec.install "ocean", "orgtrace", "rclone", "Ocean.app"
    libexec.install "node", "ocean.mjs" if File.exist?("node")
    bin.install_symlink libexec/"ocean"
    bin.install_symlink libexec/"orgtrace"
  end

  test do
    assert_match "Ocean", shell_output("#{bin}/ocean --help")
    assert_predicate libexec/"Ocean.app/Contents/MacOS/OceanBackground", :executable?
    assert_match "com.ocean.app", (libexec/"Ocean.app/Contents/Info.plist").read
  end
end
