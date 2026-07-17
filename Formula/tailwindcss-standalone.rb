class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.3.3"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.3/tailwindcss-macos-arm64"
      sha256 "cdf646702987a743464dff4d9c60fd4480d1c1e73dd819a9a67f1078815dce9d"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.3/tailwindcss-macos-x64"
      sha256 "7922e0953f2110c05976e3bf58f14e643d90427575e766b7d433f5f80cbee7e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.3/tailwindcss-linux-arm64"
      sha256 "55fd0b241214eff3de1e8ee4f22796662f2d2e7a49bcfca7477cfd0bac398195"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.3/tailwindcss-linux-x64"
      sha256 "dc61b3ac6b8c9ca874c0cc4c57b2409791a64c5540404ca5f5367360babc313a"
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
