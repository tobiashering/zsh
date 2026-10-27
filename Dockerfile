FROM ubuntu:26.04@sha256:19fcd1bf268f02b60aca3bd30bd8a6d9a11759a430e32921833e65f16d87348a

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
