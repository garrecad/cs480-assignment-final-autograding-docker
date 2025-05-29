# Use the same base image as your current container
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    wget git build-essential software-properties-common apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Install LLVM 13, flex, bison
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-13 main" && \
    apt-get update && apt-get install -y llvm-13-dev bison flex && \
    rm -rf /var/lib/apt/lists/*

# Install bats testing framework
RUN git clone https://github.com/bats-core/bats-core.git && \
    cd bats-core && ./install.sh /usr/local && \
    cd .. && rm -rf bats-core

CMD ["/bin/bash"]
