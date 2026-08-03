class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.14/ocean-darwin-arm64.tar.gz"
      sha256 "a57356318a586973f867419a87ecdc37781120d5687fb2a30f958527a5c682bf"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.14/ocean-darwin-x64.tar.gz"
      sha256 "55af658d3533520f73c9c76f13016423e3d3772b0396beafd344913608c22ede"
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
