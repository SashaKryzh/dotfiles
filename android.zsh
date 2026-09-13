# Use Android Studio's bundled JDK; projects may select a different Java version.
if [[ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]]; then
  export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  typeset -U path
  path=("$JAVA_HOME/bin" "$ANDROID_HOME/platform-tools" "$ANDROID_HOME/emulator" "$ANDROID_HOME/cmdline-tools/latest/bin" $path)
  export PATH
fi
