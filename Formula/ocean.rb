class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.12/ocean-darwin-arm64.tar.gz"
      sha256 "e003d75067f6d646729b92743a9d8f40806c55cf590c7163171d64d7e0be6b27"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.12/ocean-darwin-x64.tar.gz"
      sha256 "23aeb7eebf0b61df78f73b4953fca5b450752e296b76a4a258e845be1b49fc4b"
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
