#!/bin/bash
echo '${content}' > /var/www/html/index.html
systemctl start nginx
