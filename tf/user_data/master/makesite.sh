#!/bin/bash -x

exec >/tmp/training-server-install-debug.log 2>&1

amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx 

cat  > /usr/share/nginx/html/index.html << EOF
<head><title>Hello Pasha</title></head>
<body><h1>Hello Pasha!!</h1></body>
EOF
echo "$0 Completed"
