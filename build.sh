#!/bin/bash

EXEC_NAME="Lister_Z"
DISPLAY_NAME="Lister_Z"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="lister_z_gui.py"
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_DIR=$(xdg-user-dir DESKTOP 2>/dev/null || echo "$HOME/Desktop")
DESKTOP_FILE_NAME="Lister_Z.desktop"

echo "⚙️ Iniciando a construção do Lister Z..."

if [ ! -f "$SCRIPT_DIR/$SCRIPT_NAME" ]; then
    echo "❌ Erro: $SCRIPT_NAME não encontrado."
    exit 1
fi

mkdir -p "$APP_DIR"
mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"

# ── EMBED ICON ────────────────────────────────────────────────────────────────
echo "🖼️ Instalando ícone..."
cat > "$ICON_DIR/lister_z.svg" << 'SVGEOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="256" height="256">
  <path d="M5,20 L5,85 Q5,90 10,90 L90,90 Q95,90 95,85 L95,35 Q95,30 90,30 L50,30 L40,20 Z"
        fill="none" stroke="#3498db" stroke-width="6" stroke-linejoin="round"/>
  <line x1="22" y1="52" x2="78" y2="52" stroke="#3498db" stroke-width="6" stroke-linecap="round"/>
  <line x1="22" y1="65" x2="78" y2="65" stroke="#3498db" stroke-width="6" stroke-linecap="round"/>
  <line x1="22" y1="78" x2="60" y2="78" stroke="#3498db" stroke-width="6" stroke-linecap="round"/>
</svg>
SVGEOF
# ─────────────────────────────────────────────────────────────────────────────

echo "📦 Gerando executável..."
echo '#!/usr/bin/env python3' > "$SCRIPT_DIR/$DISPLAY_NAME"
cat "$SCRIPT_DIR/$SCRIPT_NAME" >> "$SCRIPT_DIR/$DISPLAY_NAME"
chmod +x "$SCRIPT_DIR/$DISPLAY_NAME"

echo "🖥️ Adicionando ao Menu do Sistema..."
cat > "$APP_DIR/$DESKTOP_FILE_NAME" << DESKTOPEOF
[Desktop Entry]
Name=Lister Z
Comment=Graphical interface for listing files and folders
Exec=$SCRIPT_DIR/$DISPLAY_NAME
Icon=$ICON_DIR/lister_z.svg
Terminal=false
Type=Application
Categories=Utility;FileTools;
DESKTOPEOF
chmod +x "$APP_DIR/$DESKTOP_FILE_NAME"

echo "🏠 Criando atalho na Área de Trabalho..."
cp "$APP_DIR/$DESKTOP_FILE_NAME" "$DESKTOP_DIR/$DESKTOP_FILE_NAME"
chmod 755 "$DESKTOP_DIR/$DESKTOP_FILE_NAME"

if command -v gio &> /dev/null; then
    gio set "$DESKTOP_DIR/$DESKTOP_FILE_NAME" metadata::trusted true 2>/dev/null
fi

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$APP_DIR" &> /dev/null
fi

echo "🔄 Atualizando cache do menu..."
if command -v kbuildsycoca6 &> /dev/null; then
    kbuildsycoca6 &> /dev/null
elif command -v kbuildsycoca5 &> /dev/null; then
    kbuildsycoca5 &> /dev/null
fi

# ── LAUNCH THE APP ────────────────────────────────────────────────────────────
echo "🚀 Iniciando o Lister Z..."
python3 "$SCRIPT_DIR/$SCRIPT_NAME" &
# ─────────────────────────────────────────────────────────────────────────────

echo "✅ Concluído!"
echo "   → Local:   $SCRIPT_DIR/$DISPLAY_NAME"
