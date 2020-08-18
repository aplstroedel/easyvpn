# easyvpn
- works in ubuntu/debian

Instructions:
- git clone https://github.com/aplstroedel/easyvpn.git
- cd easyvpn
- chmod -R +x ./*
- Add the iptables script to your crontab [sudo crontab -e]: @reboot /path/to/iptables.sh [interface]
- run ./easyvpn and follow the instructions.
- done! :)
