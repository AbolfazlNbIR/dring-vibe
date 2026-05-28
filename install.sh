#!/bin/bash

echo "Installing DRING-VIBE..."

sudo apt update
sudo apt install python3-pip python3-venv ffmpeg -y

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

chmod +x dringvibe.py

sudo bash -c "cat > /usr/local/bin/dring-vibe" << EOF
#!/bin/bash
$(pwd)/venv/bin/python $(pwd)/dringvibe.py "$@"
EOF

sudo chmod +x /usr/local/bin/dring-vibe

echo ""
echo "=================================="
echo "DRING-VIBE INSTALLED SUCCESSFULLY"
echo "=================================="
echo ""
echo "Run with:"
echo "dring-vibe 1"
echo ""
echo "Programmer : Abolfazl Nb"
