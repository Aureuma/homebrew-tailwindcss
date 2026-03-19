class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.2.2"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.2/tailwindcss-macos-arm64"
      sha256 "2ce66b7c8101ef1245a07d1e7abb4beb35bf512fd3beecba1cdfb327580d1252"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.2/tailwindcss-macos-x64"
      sha256 "98e34c6abd00a75a74ea2d20acf9e284241d13023133076d220c6f3ca419d920"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.2/tailwindcss-linux-arm64"
      sha256 "ad627e77b496cccada4a6e26eafff698ef0829081e575a4baf3af8524bb00747"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.2.2/tailwindcss-linux-x64"
      sha256 "4ab84f2b496c402d3ec4fd25e0e5559fe1184d886dadae8fb4438344ec044c22"
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
