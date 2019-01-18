#!/bin/bash

# Get our running IP address
ip=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)

# Write config.json
echo '{' > /var/www/xmr/config.json
echo '  "listenOn": "tcp://'$ip':50001",' >> /var/www/xmr/config.json
echo '  "pubOn": ["tcp://'$ip':9505"],' >> /var/www/xmr/config.json
echo '  "debug": true' >> /var/www/xmr/config.json
#echo '  "debug": '$XMR_DEBUG',' >> /var/www/xmr/config.json
#echo '  "ipv6RespSupport": '$XMR_IPV6RESPSUPPORT',' >> /var/www/xmr/config.json
#echo '  "ipv6PubSupport": '$XMR_IPV6PUBSUPPORT >> /var/www/xmr/config.json
echo '}' >> /var/www/xmr/config.json

php /var/www/xmr/xmr.phar
