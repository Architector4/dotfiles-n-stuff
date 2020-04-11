# Scan a load of IP addresses at once and print which responded
# Use like this: pingdiscover.sh 192.168.1.{0..255}
# (yes, this relies on your shell expanding {0..255} into 255 different arguments)
echo $@ | xargs -n1 -P0 ping -c 1 -W 1 | grep from
