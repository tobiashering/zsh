FROM ubuntu:26.04@sha256:9559ceb7c21e528e233e8dff26a0fb2682f4094cce06176eeb075d87a22b31de

# hadolint ignore=DL3064
ARG USERNAME=zsh-user

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        fontconfig \
        git \
        sudo \
        zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash "$USERNAME" \
    && usermod -aG sudo "$USERNAME" \
    && passwd -d "$USERNAME"

USER $USERNAME
WORKDIR /home/$USERNAME

COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/zsh

RUN chmod +x /home/$USERNAME/zsh/install.sh \
    && /home/$USERNAME/zsh/install.sh

CMD ["zsh"]
