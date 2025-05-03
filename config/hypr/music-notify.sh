#!/bin/bash

# playerctl --follow metadata | while read -r line; do
#     dunstify -h string:x-dunst-stack-tag:music "Now Playing" "$(playerctl metadata --format '{{ artist }} - {{ title }}')"
# done

# Caminho temporário para a capa do álbum
COVER="/tmp/album_cover.png"

# Extrai a URL da capa (Spotify/MPRIS) e baixa a imagem
function get_cover {
    URL=$(playerctl metadata --format "{{mpris:artUrl}}" 2>/dev/null)
    if [[ $URL == "file://"* ]]; then
        FILE_PATH=${URL#file://}
        cp "$FILE_PATH" "$COVER"
    elif [[ $URL == "http://"* || $URL == "https://"* ]]; then
        curl -s "$URL" -o "$COVER"
    else
        # Usa um ícone padrão se não houver capa
        cp "/usr/share/icons/Papirus/64x64/apps/music.svg" "$COVER"
    fi
}

# Monitora mudanças no player
playerctl --follow metadata | while read -r _; do
    get_cover
    dunstify -h string:x-dunst-stack-tag:music \
             -h int:value:$(playerctl metadata --format '{{ (position * 100) / mpris:length }}') \
             "Now Playing" "$(playerctl metadata --format '{{ artist }} - {{ title }}')" \
             -i "$COVER" \
             -t 5000
done
