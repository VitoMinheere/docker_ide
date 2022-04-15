FROM alpine:latest

ARG user="bosshogg"

# Set the shell to bash
SHELL ["/bin/bash", "-c"]

# Make sure all is up to date
RUN apt update && apt upgrade -y

# Install basic libraries
RUN apk add -U --no-cache \
    neovim git \
    tmux openssh-client bash \
    curl less

# Install project specific libraries
RUN apk add -U --no-cache $(cat .apk)

# Install personal config files
COPY files/bashrc .bashrc
COPY files/vimrc .vimrc
COPY files/tmux.conf .tmux.conf

