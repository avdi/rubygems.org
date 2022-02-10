FROM ruby:2.2.4

# Shush apt-get warnings
ENV DEBIAN_FRONTEND=noninteractive

# Shush "missing locale" warnings
ENV LOCALE=C

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install system packages
RUN apt-get update \
  # Install basic system packages...
  && apt-get install -y apt-utils dialog sudo openssh-client iproute2 procps lsb-release \
  # Command-line and development tools
  && apt-get install -y build-essential wget curl less git

# Set up non-root user with sudo privileges
RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
  && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
  && chmod 0440 /etc/sudoers.d/${USERNAME}

COPY .devcontainer/rubygemsorg-load-profile.sh /etc/profile.d/

# TODO consolidate package installs once they are stable
RUN apt-get install -y nodejs
RUN apt-get install -y silversearcher-ag
RUN apt-get install -y postgresql-client

# Turn interactive prompts back on for apt-get
ENV DEBIAN_FRONTEND=dialog