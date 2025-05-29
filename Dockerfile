FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install essential tools
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    git \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Add LLVM repository and install LLVM-13
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && add-apt-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-13 main" \
    && apt-get update \
    && apt-get install -y \
        llvm-13-dev \
        llvm-13-tools \
        clang-13 \
        bison \
        flex \
    && rm -rf /var/lib/apt/lists/*

# Create symlinks for easier access (optional)
RUN ln -s /usr/bin/llvm-config-13 /usr/bin/llvm-config \
    && ln -s /usr/bin/clang-13 /usr/bin/clang \
    && ln -s /usr/bin/clang++-13 /usr/bin/clang++

# Install bats-core for testing
RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core \
    && cd /tmp/bats-core \
    && ./install.sh /usr/local \
    && rm -rf /tmp/bats-core

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
