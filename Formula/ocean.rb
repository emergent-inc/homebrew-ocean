class Ocean < Formula
  desc "Shared, continuously synced coding-agent session drive"
  homepage "https://github.com/emergent-inc/ocean"
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.9/ocean-darwin-arm64.tar.gz"
      sha256 "9f62400b7da7a1a3d54f232ba1b72e2d4a4f0707c59ae5a95f6c9044a5cb0142"
    else
      url "https://github.com/emergent-inc/homebrew-tap/releases/download/v0.2.9/ocean-darwin-x64.tar.gz"
      sha256 "7c51d0dc55f65fc0bd0f44d8cb38e6b92d0597795695e4d40bf1ca7f92f788f9"
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
