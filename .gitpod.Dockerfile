FROM gitpod/workspace-full

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/
ENV PATH=/usr/lib/dart/bin:$PATH

#USER root

RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list \
    && install-packages build-essential dart libkrb5-dev gcc make

#USER gitpod

### Install Flutter
# dependencies
RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y libglu1-mesa; \
    sudo rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    mkdir ~/development; \
    cd ~/development; \
    git clone --depth 1 https://github.com/flutter/flutter.git -b stable --no-single-branch

ENV PATH="$PATH:/home/gitpod/development/flutter/bin"

RUN set -ex; \
    flutter channel beta; \
    flutter upgrade; \
    flutter config --enable-web; \
    flutter precache
