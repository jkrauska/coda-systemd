# Simple makefile for installing

USERNAME := $(shell whoami)

.PHONY: clean install

user:
	@echo "Setting daemon User to ${USERNAME}"
	sed 's/MYUSERNAME/$(USERNAME)/' coda-daemon.service.TEMPLATE > coda-daemon.service ; \
	sed 's/MYUSERNAME/$(USERNAME)/' coda-snark-worker@.service.TEMPLATE > coda-snark-worker@.service


install:
	@echo "Copying systemd service file and default config" ; \
	if ! [ "$(shell id -u)" = 0 ]; then  \
		echo "You are not root, run 'make install' as root please" ;\
		exit 1 ;\
	fi ;\
	mkdir -p /lib/systemd/system ;\
	cp coda-daemon.service /lib/systemd/system/. ;\
	cp coda-snark-worker@.service /lib/systemd/system/. ;\
	mkdir -p /etc/default ;\
	cp coda-config /etc/default/. ;\
	cp coda-config-snark-worker /etc/default/. 

clean:
	@rm coda-daemon.service coda-snark-worker@.service
