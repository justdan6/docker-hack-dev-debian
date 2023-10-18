FROM --platform=linux/amd64 debian:bullseye-slim

# Create a user
RUN adduser hack

# Set working directory
WORKDIR /app

# Install HHVM
RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    gnupg \
    && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94 \
    && add-apt-repository https://dl.hhvm.com/debian \
    && apt-get update && apt-get install -y hhvm

# Install composer
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Must be set to 1 for HHVM in docker (https://github.com/hhvm/hhvm-docker/issues/11)
RUN export HHVM_DISABLE_NUMA=1

RUN chown hack:hack /app

# Set the user
USER hack
