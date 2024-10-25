#!/usr/bin/env bash

if [[ ! $(id -u) == 0 ]]
then
 echo 'run this script as root please'
 exit
fi

if [[ ! -f /usr/bin/git ]]
then
 echo 'please install git first'
 exit
fi

if [[ -d /etc/openvpn ]]
then
 cd /etc/openvpn/
 if [[ ! -d ./easy-rsa ]]
 then
  git clone https://github.com/OpenVPN/easy-rsa.git
 fi
 cd ./easy-rsa/easyrsa3/
else
 echo 'please install openvpn first'
 exit
fi

if [[ ! -f ./vars ]]
then
 cp ./vars.example ./vars
fi

buildserver(){
echo 'enter server name'
read server
echo 'this will overwrite currently installed openvpn server configurations[y/N]'
read yesorno
case $yesorno in
 y|Y)
  cat > /etc/openvpn/server.conf <<EOF
  port 1194
  proto tcp
  dev tun
  ca ca.crt
  cert $server.crt
  key $server.key
  dh dh.pem
  tls-auth ta.key 0
  crl-verify /etc/openvpn/server/crl.pem 
  server 10.8.0.0 255.255.255.0
  ifconfig-pool-persist /var/log/openvpn/ipp.txt
  client-to-client
  keepalive 10 120
  cipher AES-256-CBC
  data-ciphers-fallback AES-256-CBC
  user nobody
  group nogroup
  persist-key
  persist-tun
  status /var/log/openvpn/openvpn-status.log
  verb 4
EOF

  ./easyrsa init-pki
  ./easyrsa build-ca nopass

  ./easyrsa gen-dh

  ./easyrsa gen-req "$server" nopass
  ./easyrsa sign-req server "$server"

  openvpn --genkey --secret ta.key

  cp pki/ca.crt /etc/openvpn
  cp pki/issued/"$server".crt /etc/openvpn/
  cp pki/private/"$server".key /etc/openvpn/
  cp pki/dh.pem /etc/openvpn/
  cp ta.key /etc/openvpn/
 ;;
 n/N)
  break
 ;;
 *)
  break
 ;;
esac
}

buildclient(){
if [[ -d ./pki ]]
then
 ./easyrsa gen-req "$client" nopass
 ./easyrsa sign-req client "$client"
 cp pki/issued/"$client".crt /etc/openvpn/
 cp pki/private/"$client".key /etc/openvpn/
else
 echo 'easyrsa not initiated yet, nothing happend'
 break
fi
}

ovpncreate(){
if [[ ! -d /etc/openvpn/files ]]
then
 mkdir -p /etc/openvpn/files
fi

if [[ ! -d /etc/openvpn/clientconfigs ]]
then
 mkdir -p /etc/openvpn/clientconfigs
fi

if [[ ! -f /etc/openvpn/clientconfigs/base.conf ]]
then
 cat > /etc/openvpn/clientconfigs/base.conf <<EOF
 client
 dev tun
 proto tcp
 remote $2 $3
 resolv-retry infinite
 nobind
 persist-key
 persist-tun
 ca [inline]
 cert [inline]
 key [inline]
 auth-nocache
 remote-cert-tls server
 tls-auth [inline] 1
 tls-client
 cipher AES-256-CBC
 data-ciphers-fallback AES-256-CBC
 verb 3
 log /var/log/openvpn/client.log
EOF
fi

KEY_DIR=/etc/openvpn
OUTPUT_DIR=/etc/openvpn/files
BASE_CONFIG=/etc/openvpn/clientconfigs/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\nkey-direction 1\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn
echo 'your .ovpn files are located in /etc/openvpn/files/'
}

revokeclient(){
 echo 'removing a client'
 echo 'name of the client? [press enter to quit]'
 read client
  if [[ ! -z "$client" ]]
  then
   ./easyrsa revoke "$client"
  else
   break
  fi
}

while true
do
 echo ' '
 echo 'OPENVPN/EASY-RSA BASIC SCRIPT'
 echo '-------------------------------'
 echo 'tell me what you want to do'
 echo '1. install/configure openvpn'
 echo '2. create client configs'
 echo '3. make the .ovpn files'
 echo '4. remove a client'
 echo 'Any other key and/or enter to exit'
 read firstanswer
 echo ' '
 case $firstanswer in
 1)
 buildserver
 ;;
 2)
 while true
 do
  echo 'enter client hostname here [press enter to quit]'
  read client
  if [[ ! -z "$client" ]]
  then
   buildclient
  else
   break
  fi
 done
 ;;
 3)
 echo 'enter server (fqdn or ip)'
 read fqdnorip
 echo 'thank you :), what port is the server listening on?'
 read port
 echo "alrighty then, let's go!"
 sleep 1.5s
 while true
 do
  echo 'which client do you want to convert to .ovpn? [press enter to quit]'
  read client
  if [[ ! -z "$client" ]]
  then
   ovpncreate "$client" "$fqdnorip" "$port"
  else
   break
  fi
 done
 unset fqdnorip
 ;;
 4)
 revokeclient
 ;;
 [!1-4]|'')
 echo 'moving on, see you later :)'
 break
 ;;
 esac
done
