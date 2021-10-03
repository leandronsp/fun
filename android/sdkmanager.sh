#!/bin/bash

sdkmanager --update
sdkmanager "platform-tools" "platforms;android-25" "emulator"
sdkmanager "system-images;android-25;google_apis;armeabi-v7a"
