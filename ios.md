# iOS development

Run `./bootstrap.sh` first. It installs `xcodes`, `aria2` for parallel downloads,
and CocoaPods. Full Xcode and simulator runtimes are separate manual steps.

## Install and select Xcode

Use [xcodes](https://github.com/XcodesOrg/xcodes) to download Apple's signed Xcode
archive and install it under `/Applications`. Xcode itself comes from Apple;
Homebrew manages the `xcodes` installer.

Check the project's `.xcode-version` or build documentation before choosing a
version. List available versions, then install the required one:

```sh
xcodes update
xcodes list
xcodes install "<version>" --select
```

Replace `<version>` with the chosen version from the list. If the project has no
version constraint, `xcodes install --latest --select` installs the latest stable
release. Complete Apple Account, verification-code, and administrator prompts
directly in Terminal.

Complete Xcode's first-launch components and verify the selected toolchain:

```sh
sudo xcodebuild -runFirstLaunch
xcodes installed
xcode-select -p
xcodebuild -version
xcodebuild -checkFirstLaunchStatus
xcodebuild -showsdks
```

The developer path should point inside the selected Xcode app's
`Contents/Developer`, and the first-launch status check should exit successfully.
To select an already installed version later, run `xcodes select "<version>"`.

## Simulator runtime

List downloadable runtimes and install an iOS version supported by the selected
Xcode and needed by the project:

```sh
xcodes runtimes
xcodes runtimes install "iOS <version>"
xcrun simctl list runtimes
xcrun simctl list devices available
```

Replace `iOS <version>` with the runtime name from the list. The installed runtime
should appear without an `unavailable` marker. Open the selected Xcode's device
management window, create an iPhone simulator if none exists, and boot it. Verify
completion with `xcrun simctl bootstatus <device-UDID> -b`, using its UDID from the
device list.

## CocoaPods and local builds

Verify `pod --version`. Homebrew provides the default CocoaPods command. When a
repository pins CocoaPods in a `Gemfile`, follow its Ruby/Bundler setup and use
`bundle exec pod install` so the project's locked version takes precedence.

Finally, follow the project's dependency setup and run its local iOS build
(for example, `bunx expo run:ios` for an Expo project). Toolchain and simulator
checks do not replace a successful project build.
