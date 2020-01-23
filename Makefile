# Simple makefile for installing

USERNAME := $(shell whoami)

.PHONY: clean install

user:
	$(info Setting daemon User to $(USERNAME))
	@sed 's/MYUSERNAME/$(USERNAME)/' coda-daemon.service.TEMPLATE > coda-daemon.service ; \
	diff -U1 coda-daemon.service.TEMPLATE coda-daemon.service ; [ $$? -eq 1 ]

install:
	@echo "Copying systemd service file and default config" ; \
	if ! [ "$(shell id -u)" = 0 ]; then  \
		echo "You are not root, run 'make install' as root please" ;\
		exit 1 ;\
	fi ;\
	mkdir -p /lib/systemd/system ;\
	cp coda-daemon.service /lib/systemd/system/. ;\
	mkdir -p /etc/default ;\
	cp coda-daemon /etc/default/.
