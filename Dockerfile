FROM silkeh/clang:13

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install Bison, Flex, and dependencies for bats
RUN apt-get update && apt-get install -y \
    bison \
    flex \
    git \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install bats-core for testing
RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core \
    && cd /tmp/bats-core \
    && ./install.sh /usr/local \
    && rm -rf /tmp/bats-core

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
