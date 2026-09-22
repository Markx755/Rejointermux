#!/data/data/com.termux/files/usr/bin/bash
# STAR Plus v5.1 — install.sh (Termux, ไม่ต้องรูท)
# ดึง zip จาก GitHub Releases อัตโนมัติ
# ผู้ใช้รันคำสั่งเดียว: curl -sL https://raw.githubusercontent.com/mzxhub99/Tool-free/main/install.sh | bash
set -e

REPO="Markx755/Rejointermux"
ZIP_URL="https://github.com/$REPO/releases/latest/download/star_rejoin_5.1.py.zip"
DIR="$HOME/star-tool"
MAIN="star_rejoin_5.1.py.zip"

echo ""
echo "  ⭐ STAR Plus v5.1 — ติดตั้งอัตโนมัติ"
echo ""

echo "[*] อัปเดตแพ็กเกจ..."
pkg update -y -q

echo "[*] ติดตั้ง python + curl + unzip..."
pkg install -y -q python curl unzip

echo "[*] ติดตั้ง requests..."
pip install -q requests 2>/dev/null || pip install requests

echo "[*] เตรียมโฟลเดอร์ $DIR ..."
mkdir -p "$DIR"

echo "[*] ดาวน์โหลด $MAIN.zip จาก Releases (เวอร์ชันล่าสุด)..."
curl -L -sS -o /tmp/star.zip "$ZIP_URL"

echo "[*] แตกไฟล์..."
unzip -o -q /tmp/star.zip -d "$DIR"
rm -f /tmp/star.zip

# ถ้า zip หุ้มโฟลเดอร์ย่อย เช่น star_rejoin_5.1/star.py ให้ย้ายขึ้นมาไว้ระดับเดียวกัน
if [ ! -f "$DIR/$MAIN" ]; then
  inner=$(find "$DIR" -mindepth 2 -name "$MAIN" | head -n 1)
  if [ -n "$inner" ]; then
    mv "$(dirname "$inner")"/* "$DIR/" 2>/dev/null || true
  fi
fi

echo "[*] เปิดสิทธิ์เข้าพื้นที่จัดเก็บข้อมูล (อ่านไฟล์ cookie จาก /sdcard ได้)..."
termux-setup-storage || true

echo ""
echo "[✅] ติดตั้งเสร็จ!"
echo ""
echo "  รันคำสั่งด้านล่างเพื่อเปิดใช้งาน:"
echo ""
echo "    cd ~/star-tool && python $MAIN"
echo ""
