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
INPUT_DIR="$BASE_DIR/input"
WORK_DIR="$BASE_DIR/work"

print_menu() {

mkdir -p "$WORK_DIR"

shopt -s nullglob
images=("$INPUT_DIR"/*.img)

if [ ${#images[@]} -eq 0 ]; then
    echo -e "[!] ${RED}No .img/valid .img files were found on: ${NC} $INPUT_DIR"
    exit 1
fi

echo -e "${GREEN}========= UNPACK PARTITIONS =========${NC}"
for i in "${!images[@]}"; do
    echo "  [$((i+1))] $(basename "${images[$i]}")"
done
echo -e "  [A] ${YELLOW}Unpack all images${NC}"
echo -e "${GREEN}=====================================${NC}"
read -p "${BOLD}Select one partition to unpack: ${NC}" choice

unpack_single() {
    local img_path="$1"
    local img_name="$(basename "$img_path" .img)"
    local target_dir="$WORK_DIR/$img_name"

    echo -e "[+] ${LIME}Unpacking${NC} $img_name ${LIME}on${NC} $target_dir..."
    mkdir -p "$target_dir"
    cp "$img_path" "$target_dir/"
    
    cd "$target_dir" || return
    "$BIN_DIR/unyaffs" "$(basename "$img_path")" > /dev/null 2>&1
    rm -f "$(basename "$img_path")"
    cd "$BASE_DIR" || return
    echo "[V] $img_name ${LIME}Sucessfully Unpacked on work/${NC}$img_name"
}

if [[ "$choice" =~ ^[Aa]$ ]]; then
    for img in "${images[@]}"; do
        unpack_single "$img"
    done
elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#images[@]}" ]; then
    unpack_single "${images[$((choice-1))]}"
else
    echo "[!] ${RED}Invalid Option${NC}"
    exit 1
fi

}

print_menu
