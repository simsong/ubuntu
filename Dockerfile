# Use the official Ubuntu image
FROM ubuntu:latest

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install common tools
RUN apt update && apt upgrade -y && \
    apt install -y \
    build-essential \
    python3 python3-pip \
    git curl wget \
    net-tools iproute2 dnsutils \
    gcc g++ make \
    openssh-client \
    nodejs npm \
    docker.io \
    sudo \
    vim nano emacs && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Ensure sudo is available without a password for the default user
RUN mkdir -p /etc/sudoers.d && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu

# Explicitly add 'ubuntu' user to sudo group
RUN usermod -aG sudo ubuntu

# Ensure Ubuntu has a proper directory
RUN mkdir -p /home/ubuntu/.ssh && chmod 700 /home/ubuntu/.ssh && chown ubuntu .ssh

# Switch to the default user that already exists in Ubuntu images
USER ubuntu
WORKDIR /home/ubuntu

# Set default shell
CMD ["/bin/bash"]
