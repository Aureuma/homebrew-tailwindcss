class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.1.18"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.18/tailwindcss-macos-arm64"
      sha256 "7f27711dceac1a580b6ad58ddac46e59202c85a6c16f2f08f6fdcdee261008e1"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.18/tailwindcss-macos-x64"
      sha256 "1e8a77fd796a3a4aa3d8727887de926ef9d38477aba113fd7c32c0d31a32a3ab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.18/tailwindcss-linux-arm64"
      sha256 "7a7702db6c93718a9b6655d455304edda18600f5a4f195242342ed3b5b70ebe8"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.18/tailwindcss-linux-x64"
      sha256 "737becf8d4ad1115ea98df69fa94026d402ca8feb91306a035b5b004167da8dd"
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
