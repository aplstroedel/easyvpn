# easyvpn
- works very nice in ubuntu/debian based systems

Instructions:
- git clone https://github.com/aplstroedel/easyvpn.git
- cd easyvpn
- chmod -R +x ./*
- run ./easyvpn and follow the instructions.
- add the iptables script to your crontab [sudo crontab -e]: @reboot /path/to/iptables.sh [interface]
- done! :)
