class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.13/ocean-darwin-arm64.tar.gz"
      sha256 "54b7ef2d2970d9b2174fd01ef2b78d59c554ff4a971ba61372c7daa73e95606a"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.13/ocean-darwin-x64.tar.gz"
      sha256 "3335367e8c3f10fcb462de7482863a0e5f156376bee2e30ce7d321cc8b433077"
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
