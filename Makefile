arch_flag := $(shell uname -m)

setup:
	@pip install -r requirements.txt

debug:
	@python main.py

docker-image:
	@docker buildx build -t iobruno/discord-bot-aarch64 . --platform linux/arm64
	# @docker buildx build -t iobruno/discord-bot-amd64 . --platform linux/amd64

docker-run:
ifeq (${arch_flag},arm64)
	@docker run iobruno/discord-bot-aarch64
endif
ifeq (${arch_flag},aarch64)
	@docker run iobruno/discord-bot-aarch64
endif
ifeq (${arch_flag},x86_64)
	@docker run iobruno/discord-bot-amd64
endif


.PHONY: setup debug docker-image docker-run
