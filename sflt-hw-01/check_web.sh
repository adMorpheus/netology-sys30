#!/bin/bash
nc -zv localhost 80 && test -f /var/www/html/index.nginx-debian.html
