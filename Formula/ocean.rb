class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.11/ocean-darwin-arm64.tar.gz"
      sha256 "7d651f4aeb910eacabb29423726448a4d4b7b1344203398f1787de0e50298e64"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.11/ocean-darwin-x64.tar.gz"
      sha256 "538b834c065528cd22e579deb61e6338029ffa9dfc29adb4d7ca334612081a92"
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
