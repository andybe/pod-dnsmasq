#!/bin/ash
SLEEP=1
DEBUG=--log-debug 
F=/etc/dnsmasq.d/default.conf

echo "127.0.0.1" > /etc/resolv.conf

echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts

function exit_function()
{
  ps   | grep dnsmasq | awk '{ print $1 }' | xargs kill -s 9 2>/dev/null
  exit 1
}

trap exit_script SIGINT SIGTERM

function update()
{
 ls -tc -la --full-time $F   | awk '{ print $7}'
}

function check_dnsmasq()
{
   count=$(ps | grep dnsmasq | wc -l)
   if [ $count -eq 1 ]; then
     dnsmasq $DEBUG
   fi
}

D=$(update)
C=$D

while true;
do
  while [ $C = $D ];
  do
    sleep $SLEEP
    D=$(update)
    check_dnsmasq
  done
  ps   | grep dnsmasq | awk '{ print $1 }' | xargs kill -s 9 2>/dev/null
  C=$D
done
