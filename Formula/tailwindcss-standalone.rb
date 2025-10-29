class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.1.16"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.16/tailwindcss-macos-arm64"
      sha256 "e6cd44b8167f5746ca32e54f6a1411dd1a6c0dd15d26a9c273b3b2ed9d87df7d"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.16/tailwindcss-macos-x64"
      sha256 "fde2aed09bf249cab9f986fd6f2089e3ce9a9ce1c7862fddbfa807c417e0f5d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.16/tailwindcss-linux-arm64"
      sha256 "967eb434f4d6a1c0dfda106decc646cb742e04d745aa484726023cdd46ba8eda"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.16/tailwindcss-linux-x64"
      sha256 "09e6876a63ceb09ccd7e5867e3dbb2b2dc65c3a2f2e2fe210d68ea3bc0432050"
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
