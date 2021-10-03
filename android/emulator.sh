#!/bin/bash

echo no | avdmanager create avd -n emuTest -k "system-images;android-25;google_apis;armeabi-v7a"

adb kill-server
adb start-server

emulator -avd emuTest -no-audio -no-boot-anim -accel on -gpu swiftshader_indirect
