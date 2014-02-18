#!/bin/bash

if [[ "$1" != "--" ]]; then
    mongoaddress="$1"
    if [[ "$mongoaddress" != "${mongoaddress/:/}" ]]; then
        sed 's/127.0.0.1:27017/'$mongoaddress'/' /var/www/xhgui/config/config.default.php > /var/www/xhgui/config/config.php
        echo "Using $mongoaddress for connecting to mongodb"
    else
        sed 's/127.0.0.1/'$mongoaddress'/' /var/www/xhgui/config/config.default.php > /var/www/xhgui/config/config.php
        echo "Using $mongoaddress for connecting to mongodb"
    fi
else
    service mongodb start
fi

echo "Starting to serve xhgui..."
php -S 0.0.0.0:80 -d max_execution_time=999999999 -d memory_limit=2147483648 -t /var/www/xhgui/webroot
