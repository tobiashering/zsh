FROM ubuntu:26.04@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

ARG USERNAME=zsh-user

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        fontconfig \
        sudo \
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
