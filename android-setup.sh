#!/usr/bin/env bash
# Called by bootstrap.sh after brew bundle. Re-running preserves existing AVDs.
set -e

if [ "$(uname -m)" != "arm64" ]; then
  echo "Skipping Android emulator setup: this configuration requires Apple Silicon."
  exit 0
fi

export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
TOOLS_ROOT="$(brew --prefix)/share/android-commandlinetools"
SDKMANAGER="$TOOLS_ROOT/cmdline-tools/latest/bin/sdkmanager"
AVDMANAGER="$TOOLS_ROOT/cmdline-tools/latest/bin/avdmanager"

# Share Homebrew's SDK with Android Studio's default location on a fresh Mac.
# Preserve an existing SDK rather than replacing it.
mkdir -p "$HOME/Library/Android"
if [ ! -e "$ANDROID_HOME" ] && [ ! -L "$ANDROID_HOME" ]; then
  ln -s "$TOOLS_ROOT" "$ANDROID_HOME"
fi
if [ ! -d "$ANDROID_HOME" ]; then
  echo "Android SDK path is not a directory: $ANDROID_HOME" >&2
  exit 1
fi

# Accept licenses for these packages; sdkmanager skips installed versions.
# No pipefail: yes may receive SIGPIPE after sdkmanager finishes reading.
yes | "$SDKMANAGER" --sdk_root="$ANDROID_HOME" \
  "platform-tools" "platforms;android-36" "build-tools;36.0.0" \
  "emulator" "system-images;android-36;google_apis;arm64-v8a"

AVD_DIR="${ANDROID_AVD_HOME:-${ANDROID_USER_HOME:-$HOME/.android}/avd}"
if [ ! -e "$AVD_DIR/Pixel_9_API_36.ini" ]; then
  printf 'no\n' | "$AVDMANAGER" create avd --name Pixel_9_API_36 \
    --package "system-images;android-36;google_apis;arm64-v8a" --device pixel_9
else
  echo "Pixel_9_API_36 already exists, skipping creation."
fi
