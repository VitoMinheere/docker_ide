MAKE := $(shell which make)
USER := $(shell whoami)

check-project:
ifndef PROJECT
	$(error missing PROJECT)
endif

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

test:           ## Output for test command
	@echo ${USER}
	@echo does nothing

copy-files:     ## Copy config files to /files for Dockerfile
	mkdir -p files
	cp /home/${USER}/.bashrc files/bashrc
	cp /home/${USER}/.config/nvim/init.vim files/vimrc
	cp /home/${USER}/.config/tmux/tmux.conf files/tmux.conf

build-ide:     ## Build container for IDE settings
	docker build -t docker-ide .
