# pialarm

A Raspberry Pi-based FM transmitter for my home alarm clock system.

## Running the transmitter

- Clone this repo and put the `music` directory at `/home/pi/music`
- Put music files in `/home/pi/music/playlist`
- Setup the systemd service which runs the transmitter
    - `sudo cp pialarm-transmit.service /etc/systemd/system/pialarm-transmit.service`
    - `sudo chmod u+rwx /etc/systemd/system/pialarm-transmit.service`
    - `sudo systemctl enable pialarm-transmit.service`
    - `sudo systemctl start pialarm-transmit.service`
- Connect a ~20cm single-conductor wire to GPIO 4 (which is pin 7 on [header P1](http://elinux.org/RPi_Low-level_peripherals#General_Purpose_Input.2FOutput_.28GPIO.29)) to act as an antenna, and tune a nearby FM radio to 103.3 Mhz.
