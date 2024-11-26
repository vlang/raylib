#!/usr/bin/env sh

set -e

# Download V
if [ ! -e 'v/' ]
then
	git clone https://github.com/vlang/v
fi

cd v
if [ ! -e './v' ]
then
	make
fi
sudo ./v symlink
cd ..

# Download Clockwork
if [ ! -e 'clockwork/' ]
then
	git clone https://github.com/EmmaTheMartian/clockwork
fi
# Build and install Clockwork
cd clockwork
../v/v install EmmaTheMartian.Maple
../v/v run . install
cd ..

# Install dependencies
clockwork deps
