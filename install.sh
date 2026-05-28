#!/bin/bash

echo "Installing DringVibe..."

sudo apt update
sudo apt install python3-pip ffmpeg -y

pip3 install -r requirements.txt

chmod +x dringvibe.py

sudo ln -sf $(pwd)/dringvibe.py /usr/local/bin/dringvibe

echo "Done."
echo "Run with:"
echo "dringvibe 1"
echo "programmer : Abolfazl Nb"