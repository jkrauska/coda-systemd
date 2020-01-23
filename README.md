# coda-systemd
This repository contains some tooling for users wanting to run coda daemons as systemd services.

### Quick Help:
```
make user
sudo make install
sudo systemctl start coda-daemon
```

### Setup:

There are two config files in the directory which you might want to adjust:
- `coda-config` contains most settings
- `coda-config-snark-worker` contains any overrides for the snark-workers (eg. thread count)

There are two simple templates provided for generating systemd unit service files.

`make user` builds the service files using the current username. (you may prefer to run the coda processes as another user)

The two generated service files are:
- `coda-daemon.service`
- `coda-snark-worker@.service`

### Install:
`sudo make install` will install the service files in to `/lib/systemd/system` and the config files in to `/etc/default`. (your OS may expect systemd files in other locations)

### Run:

Now you have normal systemd managed processes. (they will be restarted if they crash, etc.)

Start up a coda-daemon.
`sudo systemctl start coda-daemon`

Start up the number of snark workers you want to run. (This will depend on how many CPU cores you want to dedicate.)

eg. to enable and start 9
```
sudo systemctl enable coda-snark-worker@{1..9}
sudo systemctl start coda-snark-worker@{1..9}
```

### Quick systemd hints:
- `systemctl enable coda-daemon` - enable service
- `systemctl start coda-daemon` - start service
- `systemctl status coda-daemon` - check status
- `systemctl stop coda-daemon` - check status
- `journalctl -u coda-daemon` - see logs from a service



