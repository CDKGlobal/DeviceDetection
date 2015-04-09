#!/bin/bash
addgroup --gid=$(stat -c %g /opt/51d) r
adduser --disabled-password --gecos '' --uid=$(stat -c %u /opt/51d) --gid=$(stat -c %g /opt/51d) r
adduser r sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su -m r -c /opt/51d/build
