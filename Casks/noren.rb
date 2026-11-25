# Bumped by noren's release workflow (github.com/skytect/noren, .github/workflows/release.yml)
cask "noren" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/skytect/noren/releases/download/#{version}/Noren-#{version}.zip"
  name "Noren"
  desc "Bar, workspace strip and window border for the AeroSpace window manager"
  homepage "https://github.com/skytect/noren"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Noren.app"
  binary "#{appdir}/Noren.app/Contents/MacOS/noren"

  # Releases are signed with noren's own certificate, not notarized
  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/Noren.app"], must_succeed: false
  end

  uninstall quit: "local.noren"

  zap trash: [
    "~/.config/noren",
    "~/Library/Application Support/noren",
  ]

  caveats <<~EOS
    noren asks for Accessibility, Input Monitoring and Screen Recording when it starts.

    To start it at login, add Noren in System Settings > General > Login Items.

    The optional Dock payload needs System Integrity Protection partly off:
      https://github.com/skytect/noren/blob/main/docs/dock.md
  EOS
end
