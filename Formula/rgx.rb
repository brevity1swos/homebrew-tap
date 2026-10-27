class Rgx < Formula
  desc "A terminal regex tester with real-time matching, multi-engine support, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.14.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.14.3/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "52debbc56a8f85e610a1b0c3d41323f30ff87062d80ee50f1660d23f5f9fffc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.14.3/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "33b77144ab638d71969c86ea8e7c45319a512142a62afd921f41b2efa81d2f78"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.14.3/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5724b4fec34e94c65d3ee3eb14f19eff1a998f7092546cc8263151a3e7fb49eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.14.3/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "20cecef022be47731797797ca2148aabd31de9049f15d0d572cb79e848bd3b90"
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
