# easyvpn

preconfig:
- git clone https://github.com/aplstroedel/easyvpn.git
- cd easyvpn
- chmod -R +x ./*
- Add the iptables script to your crontab [sudo crontab -e]: @reboot /path/to/iptables.sh
- run ./easyvpn and follow the instructions.
- done! :)
