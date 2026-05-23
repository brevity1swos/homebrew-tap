class Rgx < Formula
  desc "A terminal regex tester with real-time matching, multi-engine support, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.12.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.12.3/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4fe8fa38e1ae6ef143c119cffcfe6c547eaa228f6d3d893e93fbf02ecfd0abc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.12.3/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2d5ffbddf46b6deca347b0ce84143d55947a71cc0d4e79d92c13f9f960cc86f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.12.3/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5b350414a091d44d652b4173f9fa4a35e78e31f8b6224c82f278a28f9f9dd87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.12.3/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60347892c015151e5098bb6a8927e537441a1fc3296dc60be6bd77fae3e7a0e1"
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
