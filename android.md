# Android development on Apple Silicon

Run `./bootstrap.sh`. Homebrew installs `android-studio` and
`android-commandlinetools`; `android-setup.sh` then installs:

- Android SDK platform API 36 and Build Tools 36.0.0.
- Platform Tools (`adb`) and the Android Emulator.
- One API 36 Google APIs ARM64 system image and a `Pixel_9_API_36` AVD.

The setup accepts the required Android SDK package licenses. It does not launch
Android Studio or the emulator. Re-running skips installed SDK versions and
preserves the existing AVD and its data. Intel Macs skip SDK/emulator setup.

On a fresh Mac, `~/Library/Android/sdk` links to Homebrew's
`share/android-commandlinetools` directory, so Studio and terminal tools share
one SDK. An existing SDK directory is preserved and receives the packages instead.
Homebrew owns the command-line tools; `sdkmanager` owns the other SDK packages.

`android.zsh` is symlinked into Oh My Zsh's custom directory. It sets `JAVA_HOME`
to Android Studio's bundled JDK and adds Java, SDK tools, and the emulator to
`PATH`. Restart the terminal after bootstrap. No separate Temurin is installed.
Studio's JDK version changes with updates (Java 25 in the verified setup); older
Gradle projects may require Java 17 or another compatible JDK. Additional SDK,
NDK, or CMake versions depend on the project and are not installed by default.

## Verify and launch

```sh
java -version
sdkmanager --sdk_root="$ANDROID_HOME" --list_installed
emulator -accel-check
emulator -list-avds
emulator -avd Pixel_9_API_36
```

In another terminal, after the emulator starts:

```sh
adb devices -l
adb -e shell getprop sys.boot_completed
```

Expect an emulator with status `device` and a boot property of `1`.
If multiple emulators are running, use `adb -s <serial>` instead of `adb -e`.
The emulator opens a window; provisioning requires no UI interaction.
An app build is a separate check, for example `npx expo run:android` inside an
Expo project.

Google now deprecates `sdkmanager` and `avdmanager` in favor of the Android CLI.
The setup uses the commands verified on this Mac, which remain included in the
Homebrew command-line tools package.

References: [SDK manager](https://developer.android.com/tools/sdkmanager),
[AVD manager](https://developer.android.com/tools/avdmanager),
[Java compatibility](https://developer.android.com/build/jdks).
