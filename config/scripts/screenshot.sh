#!/bin/bash

# Script simples de screenshot para Hyprland usando grim
# Salva em ~/Imagens/screenshots com nome aleatório

# Diretório de salvamento
SAVE_DIR="$HOME/Imagens/screenshots"
mkdir -p "$SAVE_DIR"

# Gerar nome aleatório para o arquivo
FILENAME="$SAVE_DIR/screenshot_$(date +%s)_$RANDOM.png"

# Capturar a tela inteira
grim "$FILENAME"

# Notificação
notify-send "Captura de tela" "Screenshot salvo em $FILENAME" -i "$FILENAME"

# Copiar para área de transferência (opcional)
wl-copy < "$FILENAME"