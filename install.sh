#!/bin/bash

SCRIPT_DIR="./config/scripts" 
TARGET_DIR="$HOME/bin"
PACKAGES=(
    waybar
    fastfetch
    kitty
    hyprlock
    hyprpaper
    grim
    hyprland
    wofi
    docker
    firefox
    steam
    discord
    nemo
    git
)

echo "Instalando pacotes"
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm "${PACOTES[@]}"

echo "Aplicando Rice"
sudo mkdir -p ~/.config/
sudo cp ./config/* ~/.config/
sudo cp ./home/* ~/

echo "Criando links simbólicos em '$TARGET_DIR'..."
chmod +x "$SCRIPT_DIR"/*
mkdir -p "$TARGET_DIR"

for script in "$SCRIPT_DIR"/*; do
    if [ -f "$script" ]; then  
        script_name=$(basename "$script")
        target_path="$TARGET_DIR/$script_name"

        if [ -L "$target_path" ]; then
            rm "$target_path"
        fi

        ln -s "$(realpath "$script")" "$target_path"
        echo "✅ $script_name → $target_path"
    fi
done

echo "Instalação completa. Reinicie a maquina"