class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.17/ocean-darwin-arm64.tar.gz"
      sha256 "6fb1aa040d61a9a77eb4c213eed6a0b4b868df5f30f8eae4b0cc5878b61085f3"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.17/ocean-darwin-x64.tar.gz"
      sha256 "ae40950c2e158b1c949983486a3258c2ef51638df71d460a0b74471540c779cf"
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
