# pi-fm-player

A Raspberry Pi-based music player + FM transmitter, originally created for my home alarm clock. `pi-fm-player` continuously transmits MP3s stored locally, in a random order, on the FM frequency of your choice.

## Hardware Setup

Connect a ~20cm/8in single-conductor wire to GPIO 4 (which is pin 7 on [header P1](http://elinux.org/RPi_Low-level_peripherals#General_Purpose_Input.2FOutput_.28GPIO.29)) to act as an antenna.

## Install & Configure

On the Raspberry Pi:

- Place the `pifm` directory from this repo at a location of your choosing.
  - I placed it in `/opt` on my Raspberry Pi.
  - You may wish to adjust file permissions if installing it in `/opt` or similar. I did this by running `sudo chown -R root:root /opt/pifm`.
- Put MP3 files in a directory of your choice.
  - I'm using [Syncthing](https://syncthing.net) to sync music to `~/Music` on my Pi.
- Setup `pifm-player.service`, the systemd service which runs the transmitter.
  - First, customize `pifm-player.service`.
  - Set the environment variables `MUSIC_DIR` and `PIFM_BIN` to point to the music directory and the `pifm` binary on your system.
  - Set the variable `PIFM_FREQ` to change to a different FM frequency.
  - `sudo mv pifm-player.service /etc/systemd/system/`
  - `sudo chmod 0644 /etc/systemd/system/pifm-player.service`
- Finally, enable and run the transmitter service:
  - `sudo systemctl enable pifm-player.service`
  - `sudo systemctl start pifm-player.service`

## Logs

> Is it working?

```shell
sudo journalctl -f -u pifm-player.service
```

> What was playing at some point in the past?

```shell
sudo journalctl -u pialarm-transmit.service --since "2019-10-21 07:30:00" --until "2019-10-21 07:50:00"
```

## License

Released under the [Unlicense](https://choosealicense.com/licenses/unlicense/) (see `LICENSE` in this repo).

## Author

Chris Dzombak

- [github.com/cdzombak](https://www.github.com/cdzombak)
- [dzombak.com](https://www.dzombak.com)
