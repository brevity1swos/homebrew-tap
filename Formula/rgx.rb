class Rgx < Formula
  desc "A terminal regex tester with real-time matching, multi-engine support, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.11.0/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "60fec2314c3a4727f35e2f5d1a88cb3579e74d49f1b408d477852c9efa717763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.11.0/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "815695e7e9ccc3c80b0dc7fdd08f4b5e95aab6c32bebbae8e6ac5bb09a5a5852"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.11.0/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e3eb9f09b334eb2742587124f0a6c969ab4b1a80fbefb10db05a987a2254cb87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.11.0/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1284630eaab6222cf7bcfadf8fbefd594836365b9c201d7b44a2a68fdfcaa92e"
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
