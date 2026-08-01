class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.10/ocean-darwin-arm64.tar.gz"
      sha256 "9fa25cb258e90a07a47987e747ae0a4e7ae0a0b82d40f90c1e6f86bf8b5dedc1"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.10/ocean-darwin-x64.tar.gz"
      sha256 "0173b0401ef6b9561f160975cee00cb7e5d7d5614bede3f1207733a6a274f8db"
    end
  end

  def install
    libexec.install "ocean", "orgtrace", "rclone"
    libexec.install "node", "ocean.mjs" if File.exist?("node")
    bin.install_symlink libexec/"ocean"
    bin.install_symlink libexec/"orgtrace"
  end

  test do
    assert_match "Ocean", shell_output("#{bin}/ocean --help")
  end
end
