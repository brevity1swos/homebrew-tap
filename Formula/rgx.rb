class Rgx < Formula
  desc "A terminal regex tester with real-time matching, multi-engine support, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.10.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.10.2/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b2f8fd7cf83df633b4dfa243f2d456152bc49b47d57452561ed9d608fab15939"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.10.2/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c830f6460576d5f8c881ff762d1dfc61aa91ea59d01846cd9efe42bdec32a10f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.10.2/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09ccf00b43038a2c9ae939af63bfaf5588b4ec1bba1dbcb2cc72201d3efa3b17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.10.2/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a5bb26c1859a2289cfdeeac79760cf9248631f647112076967613a16f9faf59f"
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
