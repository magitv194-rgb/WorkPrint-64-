SHELL := /bin/sh
LB ?= lb
CONFIG_SCRIPT := sh ../tools/configure-live-build.sh

.PHONY: help config build clean check
help:
	@printf '%s\n' 'WorkPrint 64 Linux image targets:' '  make config  - generate live-build configuration' '  make build   - build the hybrid ISO (run as root or with suitable privileges)' '  make check   - run local configuration checks' '  make clean   - remove generated live-build output'

config:
	$(CONFIG_SCRIPT)

build: config
	$(LB) build

check:
	../tools/check-live-config.sh

clean:
	$(LB) clean --purge
