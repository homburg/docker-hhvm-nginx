#!/bin/bash

## Usage
# $1 user
# $2 writeable home dir
# $3 web root

export HOME="$2"

/etc/init.d/nginx start
cd $2; sudo -u $1 hhvm --mode server -vServer.Type=fastcgi -vServer.Port=9000
