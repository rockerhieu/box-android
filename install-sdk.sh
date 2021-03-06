#!/bin/sh

export ANDROID_SDK_VERSION="23.0.2"

# Install SDK
wget "http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz"
tar xzf "android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz"
rm "android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz"


# Set environment variables
export ANDROID_HOME=${PWD}/android-sdk-linux
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

type android || { echo "Path: $PATH"; echo 'Android not availble after installation, terminating.'; exit 1; }

echo y | android update sdk --no-ui --all --filter "tools"
echo y | android update sdk --no-ui --all --filter "build-tools-21.1.1"

export ANDROID_BUILD_TOOLS="21.1.1"


# Write environment variables setup to $profile
echo "export ANDROID_HOME=\"${ANDROID_HOME}\"" | sudo tee -a $profile
echo "export ANDROID_SDK_VERSION=\"${ANDROID_SDK_VERSION}\"" | sudo tee -a $profile
echo "export ANDROID_BUILD_TOOLS=\"${ANDROID_BUILD_TOOLS}\"" | sudo tee -a $profile
echo "export PATH=\"${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools\"" | sudo tee -a $profile

# Print $profile
echo -e "$profile updated to:\n\n$(cat $profile)"
