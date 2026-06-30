class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.3.2"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.2/tailwindcss-macos-arm64"
      sha256 "b800b0659dc64b9f03ede5660244d9415d777d5739ae2889280877ca37be742a"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.2/tailwindcss-macos-x64"
      sha256 "cef8f110471e889c3c4409055cf8aff33076f58a081867b0dfc6534b290bfbb0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.2/tailwindcss-linux-arm64"
      sha256 "394ddccc2402cfa3abd97dfba56f3587781a3d6e6ce66e65ceada14beb7664b8"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.3.2/tailwindcss-linux-x64"
      sha256 "5036c4fb4328e0bcdbb6065c70d8ac9452e0d4c947113a788a8f94fd390425c1"
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
