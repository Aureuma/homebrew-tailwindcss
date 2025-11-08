class TailwindcssStandalone < Formula
  desc "Standalone CLI for Tailwind CSS - no Node.js required"
  homepage "https://tailwindcss.com"
  version "v4.1.17"
  license "MIT"

  # NOTE: SHA256 checksums will be automatically updated by the GitHub Actions workflow
  # The workflow runs daily and on manual trigger to fetch latest releases
  # Initial checksums should be updated by running the workflow manually after setup
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.17/tailwindcss-macos-arm64"
      sha256 "852b62d91a6dfa56969686bc8a4bae0e4722de8f5a9b42b102bb589b7ece8cfe"
    else
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.17/tailwindcss-macos-x64"
      sha256 "6337c87185321c079244dfbd9c24502a3006401bd1539d19cdc9df8de9101843"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.17/tailwindcss-linux-arm64"
      sha256 "264689984311cc2ca104a9d6a4d039b4267aecf4543dc9ea0bbc094eeb0ccc8d"
    elsif Hardware::CPU.intel?
      url "https://github.com/tailwindlabs/tailwindcss/releases/download/v4.1.17/tailwindcss-linux-x64"
      sha256 "cc115d9b6c4ede4e423bfea6a3cfc3f03e6c1702b7d910369b9540e2b4cf3860"
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
