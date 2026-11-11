#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin"
BACKUP_BIN="$INSTALL_DIR/backup"
RAW_URL="https://raw.githubusercontent.com/tibocub/backup.sh/main/backup"

echo "==> Setting up the backup utility..."

# 1. Prompt user for custom paths with smart defaults
read -p "Enter your local projects directory [$HOME/Code/perso]: " input_local
LOCAL_DIR="${input_local:-$HOME/Code/perso}"

read -p "Enter your local backup repo directory [$HOME/Code/backup]: " input_backup
BACKUP_REPO_DIR="${input_backup:-$HOME/Code/backup}"

# 2. Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo "==> Downloading backup script from GitHub..."
TEMP_SCRIPT=$(mktemp)

if command -v curl >/dev/null 2>&1; then
    curl -sSL "$RAW_URL" -o "$TEMP_SCRIPT"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TEMP_SCRIPT" "$RAW_URL"
else
    echo "Error: Neither curl nor wget is installed. Please install one of them." >&2
    exit 1
fi

# 3. Replace placeholders with user's customized paths
# (Using '|' as delimiter in sed to avoid issues with slashes in file paths)
sed -i.bak "s|__LOCAL_DIR__|$LOCAL_DIR|g" "$TEMP_SCRIPT"
sed -i.bak "s|__BACKUP_REPO_DIR__|$BACKUP_REPO_DIR|g" "$TEMP_SCRIPT"
rm -f "${TEMP_SCRIPT}.bak"

# 4. Move to destination and make executable
mv "$TEMP_SCRIPT" "$BACKUP_BIN"
chmod +x "$BACKUP_BIN"

echo "==> Successfully installed 'backup' to $BACKUP_BIN!"

# 5. PATH check
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Warning: '$INSTALL_DIR' is not currently in your \$PATH."
    echo "To use 'backup' from anywhere, add this line to your ~/.bashrc or ~/.zshrc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
else
    echo "You're all set! Run 'backup push' or 'backup pull' from anywhere."
fi
