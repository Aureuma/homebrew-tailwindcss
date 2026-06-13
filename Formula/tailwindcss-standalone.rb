class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.3.1"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.1/tailwindcss-macos-arm64"
      sha256 "a27c43626185953ee19bdace1939c7601e55da654e0b2fc4461e3e29957aa739"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.1/tailwindcss-macos-x64"
      sha256 "e9e830ceb3e70b7e0775a3dd79eee8ec82c6b31270f08f2fa2857d0077045ac3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.1/tailwindcss-linux-arm64"
      sha256 "3d662377a86d71c43b549dc06b90db4586b4acd412bf827a3268e951661e5adf"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.1/tailwindcss-linux-x64"
      sha256 "2526d063ba03b71f9a3ea7d5cee14f0aec147f117f222d5adc97b1d736d45999"
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
