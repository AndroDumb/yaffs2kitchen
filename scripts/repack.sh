#!/usr/bin/env bash

# Colors
GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[0;34m'
CYAN=$'\033[0;36m'
BOLD=$'\033[1m'
LIME=$'\033[0;92m'
PURPLE=$'\033[0;35m'
LIGHT_GRAY=$'\033[0;37m'
DARK_GRAY=$'\033[1;30m'
NC=$'\033[0m'

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BIN_DIR="$BASE_DIR/bin"
WORK_DIR="$BASE_DIR/work"
OUTPUT_DIR="$BASE_DIR/output"

print_menu() {

mkdir -p "$OUTPUT_DIR"

folders=("$WORK_DIR"/*/)

if [ ${#folders[@]} -eq 0 ] || [ ! -d "${folders[0]}" ]; then
    echo -e "[!] ${RED}There aren't extracted partitions in $WORK_DIR ${NC}"
    exit 1
fi

echo -e "${GREEN}======== REPACK PARTITIONS ========${NC}"
for i in "${!folders[@]}"; do
    folder_name="$(basename "${folders[$i]}")"
    echo "  [$((i+1))] $folder_name"
done
echo "  [A] ${YELLOW}repack all partitions${NC}"
echo "${GREEN}====================================${NC}"
read -p "${BOLD}Select one partition to repack: ${NC}" choice

repack_single() {
    local folder_path="$1"
    local folder_name="$(basename "$folder_path")"
    local out_img="$OUTPUT_DIR/${folder_name}_repacked.img"

    echo -e "[+] ${LIME}Repacking $folder_name ${NC} -> $out_img..."
    "$BIN_DIR/mkyaffs2image" "$folder_path" "$out_img" > /dev/null 2>&1
    echo -e "[V] ${LIME}Repacked sucessfully:${NC} output/${folder_name}_repacked.img"
}

if [[ "$choice" =~ ^[Aa]$ ]]; then
    for folder in "${folders[@]}"; do
        repack_single "$folder"
    done
elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#folders[@]}" ]; then
    repack_single "${folders[$((choice-1))]}"
else
    echo "[!] ${RED}Invalid Option.${NC}"
    exit 1
fi

}

print_menu
