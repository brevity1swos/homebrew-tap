class Rgx < Formula
  desc "A terminal regex tester with real-time matching, multi-engine support, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.9.0/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5a7fc28cdff2cdafe1a12f0337045681ca1e8e88b360293b830a1e93c3b38963"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.9.0/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8ad00859d234ca224c27c0f02bd271e66dad5c15b2b2fd0bbc4d7d6e73313034"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.9.0/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "95441b251814110dd6bc6564107eac972f61bd9a56f0f4d383e557bd2100ca66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.9.0/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0addb2ff0f3ab13f973dc7846ce8cd90205023a55355b102c226fcbd9312484d"
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
