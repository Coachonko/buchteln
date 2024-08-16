#!/bin/bash

set -e

podman build --tag=buchteln .

mkdir -p ${HOME}/.config/containers/systemd
cp buchteln.container ${HOME}/.config/containers/systemd

systemctl --user daemon-reload
systemctl --user start buchteln