FROM ubuntu AS base
RUN apt-get update && apt-get install -y curl zip unzip openjdk-11-jdk
RUN curl -s https://get.sdkman.io | bash
RUN ["bash", "-c", "source \"/root/.sdkman/bin/sdkman-init.sh\" && sdk install kotlin"]
