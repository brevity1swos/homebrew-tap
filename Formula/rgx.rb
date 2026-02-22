class Rgx < Formula
  desc "A terminal regex debugger with real-time matching, capture group highlighting, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.3.0/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "eb15a3797b244f16ceebaf47188ef4d62c41f307971986f7bd79fde10ad05a6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.3.0/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "54c60500630bad6fe800bd250c0b14327a34413a2e67e7c25cdddfb6c0fb96fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.3.0/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "119ccebedfd3b32c402f74b470061bdf518d6fcc48e1524693a8832a462771bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.3.0/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "18930df902873ae72b5f86e139ee237cbeaadcfb0d718839a2e94bcbed99c84e"
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
