#!/bin/bash

clear
echo "=================================="
echo "      INSTALLING DRING-VIBE"
echo "=================================="

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# نصب پیش‌نیازهای سیستم
echo "[+] Installing system dependencies..."
sudo apt update -qq
sudo apt install -y python3 python3-pip python3-venv ffmpeg libsdl2-mixer-2.0-0 -y

# ساخت محیط مجازی
echo "[+] Setting up virtual environment..."
python3 -m venv "$PROJECT_DIR/venv"

# نصب کتابخانه‌های پایتون داخل venv
echo "[+] Installing python packages..."
"$PROJECT_DIR/venv/bin/pip" install --upgrade pip
"$PROJECT_DIR/venv/bin/pip" install pygame pynput rich

# ایجاد فایل اجرایی در مسیر سیستم
echo "[+] Creating global command..."
sudo rm -f /usr/local/bin/dring-vibe

sudo tee /usr/local/bin/dring-vibe > /dev/null << EOF
#!/bin/bash
cd "$PROJECT_DIR"
source "$PROJECT_DIR/venv/bin/activate"
exec python3 "$PROJECT_DIR/dringvibe.py" "\$@"
EOF

sudo chmod +x /usr/local/bin/dring-vibe
chmod +x "$PROJECT_DIR/dringvibe.py"

echo "=================================="
echo " DRING-VIBE INSTALLED SUCCESSFULLY "
echo "=================================="
echo "Usage: dring-vibe [theme_number]"
