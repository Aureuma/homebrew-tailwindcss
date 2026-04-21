class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.2.4"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.4/tailwindcss-macos-arm64"
      sha256 "932f7045205283f4b26f9a4c3f027958526bf5bcc8577a7e2f18002e1eb5145e"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.4/tailwindcss-macos-x64"
      sha256 "4fcbbf4e680e462365a41feaaf4414f92c25f5bcc0a7729a62432c05e8173733"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.4/tailwindcss-linux-arm64"
      sha256 "30fa5ad8d26e8f5aaeb7e500da6015543c5bbbfb7d7d775b83fbc3fb9cd5ef7c"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.4/tailwindcss-linux-x64"
      sha256 "cabeef049cdeab61a5fa6b65ea28a3e8e53b8a85e58883947868c730fc48bdec"
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
