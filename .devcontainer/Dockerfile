# This should be kept consistent with .ruby-version
ARG RUBY_VERSION=2.2.4

FROM ruby:${RUBY_VERSION}

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive  

# Install system packages. 
RUN apt-get update \
  # Install packages needed to install new package sources
  && apt-get install -y --no-install-recommends \
  wget gnupg gnupg2 software-properties-common \
  # Refresh package lists
  && apt-get update \
  && apt-get -y install --no-install-recommends \
  # Tools for adding extra package repos
  apt-transport-https \
  # Tools for adding extra package repos
  apt-utils \
  # Bash shell autocompletion for various commands
  bash-completion \
  # Basic compile toolkit (GCC, Make, etc.)
  build-essential \
  # Compression utility
  bzip2 \
  # Certs needed to establish secure SSL/TLS connections
  ca-certificates \
  # Enable admin tools to present console "GUIs"
  dialog \
  # Util to identify file types
  file \
  # Version control
  git \
  # Diagramming/visualization tool
  graphviz \
  # Interactive process manager
  htop \
  # provides ifconfig, netstat, etc.
  iproute2 \
  # the `ping` command
  iputils-ping \
  # Util for querying JSON data
  jq \
  # Console text viewer
  less \
  # Postgres client library, needed for Ruby Postgres bindings
  libpq-dev \
  # Needed to compile Ruby
  libreadline-dev \
  # SQLite client libraries, needed to compile SQLite gem
  libsqlite3-dev \ 
  # SSL library needed to compile Ruby
  libssl-dev \
  # XML libs needed for Nokogiri
  libxml2 \
  # Localization data (avoids annoying missing-locale warnings)
  locales \
  # Indexed file search utility 
  locate \
  # Tool to query details about the OS
  lsb-release \
  # Library tracing tool
  ltrace \
  # SSH secure shell
  openssh-client \
  # Needed by libpq
  postgresql-client \
  # CLI tools for interacting with Redis
  redis-tools \
  # MIME file type sniffing database used by mimemagic gem (which is used by ActiveStorage)
  shared-mime-info \
  # SQLite database
  sqlite \
  # System call tracing tool
  strace \
  # Execute commands as root
  sudo \
  # Pretty directory listings
  tree \
  # Time zone data
  tzdata \
  # Text editor
  vim \
  # Repeatedly run a command and watch for output changes
  watch \
  # File download utility
  wget \
  # Compression libs. Needed to compile Ruby.
  zlib1g-dev \
  # Z Shell. Alternative to Bash.
  zsh \
  # Set the locale
  && localedef -i en_US -f UTF-8 en_US.UTF-8 \
  # Add non-root user
  && groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  # Give sudo access to non-root user. This must happen AFTER installing sudo.
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  # Clean up to slim down the layer
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

USER ${USERNAME}
WORKDIR /home/${USERNAME}
