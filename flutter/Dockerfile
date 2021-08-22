FROM ubuntu as base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
WORKDIR /app

RUN mkdir -p /android-sdk
ENV ANDROID_SDK_ROOT /android-sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools /android-sdk/tools
RUN cd /android-sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd /android-sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/android-sdk/platform-tools"

RUN rm -rf /flutter
RUN mkdir -p /flutter
RUN wget -O /flutter/flutter_linux_2.2.3-stable.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.3-stable.tar.xz
RUN tar xvf /flutter/flutter_linux_2.2.3-stable.tar.xz -C /
ENV PATH "$PATH:/flutter/bin"
