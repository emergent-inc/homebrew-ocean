class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.16/ocean-darwin-arm64.tar.gz"
      sha256 "b8ac01f5186f2d3ee5864d7ddb60b3313ebd8110f05a32e891efb2e256edff6f"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.16/ocean-darwin-x64.tar.gz"
      sha256 "dca59617448a0b3a3ff7f333d0cadd0c252f664aec8668712ea2fd0c8c1d35ad"
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
