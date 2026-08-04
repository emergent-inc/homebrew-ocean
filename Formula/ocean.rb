class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.18"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.18/ocean-darwin-arm64.tar.gz"
      sha256 "1af8d27e5cce4d4145619b5121011471b5ce66a0ba46d583908f669f3c0a1bd8"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.18/ocean-darwin-x64.tar.gz"
      sha256 "60f783667bf7cad323eab837b4fd25bfe7ccf4177591a8388f03a1dbcd2557ec"
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
