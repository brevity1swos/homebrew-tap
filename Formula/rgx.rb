class Rgx < Formula
  desc "A terminal regex debugger with real-time matching, capture group highlighting, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.1.9/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b8a9679a816951ff85fd85b4e14a273f43e5e060643031e3ee766ac35b401cf2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.1.9/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "caaedcea49a1304c17f27bfed8b5056eeaaffdc3ca69bfdfa53b972fbd12de7d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.1.9/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5554d465e4c4a845b150b826ff8f3d766b80131a08c199ac7d72ddca4f294bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.1.9/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9125722790b13857b7cf5edeb9a27025fc6f5dd15e4ae61b19b2037828ba65f9"
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
