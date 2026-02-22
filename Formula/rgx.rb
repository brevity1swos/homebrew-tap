class Rgx < Formula
  desc "A terminal regex debugger with real-time matching, capture group highlighting, and plain-English explanations"
  homepage "https://github.com/brevity1swos/rgx"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.4.1/rgx-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2b457e652024af63b75e5b3b22dacb37f6f9b64a6039001a7796cfc017ffd4e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.4.1/rgx-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5af45380beef064a1d0c7492ac4a8e97ea7c61b8fa6e66943e5451eb31d0d8db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.4.1/rgx-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e10c73f2f67f3aa4f891f6e1ea0a58c17114e9cc5f176b2d9f474508236f7526"
    end
    if Hardware::CPU.intel?
      url "https://github.com/brevity1swos/rgx/releases/download/v0.4.1/rgx-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a03d9f06cd049df0a827165fc09b833a4b74395ae8a0de10e852f853b5f99c9"
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
