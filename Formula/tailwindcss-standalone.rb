class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.2.0"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.0/tailwindcss-macos-arm64"
      sha256 "d9e759fd6612dd442a9caa49d366b24e5097ea9802d35829da3f6db6ee5c2043"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.0/tailwindcss-macos-x64"
      sha256 "18cd6bb94d0f26ff8a0fa8a966beb9ea36bea2c7c444397f7619a2b880260e65"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.0/tailwindcss-linux-arm64"
      sha256 "376fd4da2c29eb81ae0638cd2f84a4304af92532f2f1576555f41bdb44c185da"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.0/tailwindcss-linux-x64"
      sha256 "8f65e2d21c675f1e8d265219979d17d10634c1f553a2f583265b7edb28726432"
    end
  end

  def install
    # Rename the downloaded binary to tailwindcss
    raise "Binary not found" if Dir["tailwindcss-*"].empty?
    bin.install Dir["tailwindcss-*"].first => "tailwindcss"
    chmod 0755, bin/"tailwindcss"
  end

  def caveats
    <<~EOS
      The tap auto-updates daily via GitHub Actions to keep TailwindCSS current.
      If Homebrew reports a checksum mismatch, run `brew update` to pull the
      latest tap revision before reinstalling.
    EOS
  end

  test do
    # Test that the binary runs and shows version
    system bin/"tailwindcss", "--help"
  end
end
