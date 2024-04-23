#!/bin/bash
rsync -av --delete --exclude=".*"  ~/ /tmp/backup >> /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Backup successful" >> /var/log/syslog
else
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Backup failed" >> /var/log/syslog
fi
