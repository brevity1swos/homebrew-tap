class Rgx < Formula
  desc "A terminal regex debugger with real-time matching, capture group highlighting, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.5.1/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "98506f69deb8fed59f6af42b9a1227700c745c5ba1f7f8f375e925eb0e930718"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.5.1/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "eaf41fb34b7272a8c6a4b3afd9a2c98e0ed8b58051f4a33cfbbb028084a3334f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.5.1/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d3d036f5ff72e8f3a2a5db22e7bea247f40a7ffaccceccea94a07bf63f115eb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.5.1/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4893a6e5c5ef274f717e427d8d966d85a3dfc0f636b05bb4d63f3d3e4dff85a8"
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
