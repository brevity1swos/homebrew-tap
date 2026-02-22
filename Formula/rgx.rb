class Rgx < Formula
  desc "A terminal regex debugger with real-time matching, capture group highlighting, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.2.0/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c7be0b2d7ece77f621580de8e8fc5663d43e2d92ba9ff77525edf01a43323c4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.2.0/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a70d0d9a99ee3cb8be2fcc9b0b298fbb148225e3f4533b1947bab3c6af23666b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.2.0/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "90306410f6574621b41bcb2e493fc84e97d384d5e3e64b07132885081e90c303"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.2.0/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3551d2897e278fc8f600956ed413e95b847ffe5d2f5acdf0f1f0563a959faf87"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rgx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rgx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rgx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rgx"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
