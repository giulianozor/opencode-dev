FROM golang:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN printf 'export PATH="$PATH:/usr/local/go/bin:/go/bin"\n' > /etc/profile.d/golang-path.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        wireguard-tools \
        openresolv \
        iproute2 \
        iputils-ping \
        iptables \
        curl \
        ca-certificates \
        gnupg ffmpeg chromium nano \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://opencode.ai/install | bash \
    && ln -sf "$HOME/.opencode/bin/opencode" /usr/local/bin/opencode

WORKDIR /workspace
CMD ["/bin/bash"]
