#!/bin/bash
umask 0002
function replace_variables {
    ESCAPED_URL=$(echo $ROOT_URL | sed 's/\//\\\//g')
    /usr/bin/sed -ie "s/#{ROOT_URL}/$ESCAPED_URL/g" /opt/gogs/custom/conf/app.ini
}

echo "Configuring app.ini"
replace_variables

exec /opt/gogs/gogs web
