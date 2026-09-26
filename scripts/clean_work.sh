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
WORK_DIR="$BASE_DIR/work"

print_menu() {
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}       CLEANING OF DIRECTORIES......          ${NC}"
echo -e "${GREEN}==========================================${NC}"

if [ ! -d "$WORK_DIR" ] || [ -z "$(ls -A "$WORK_DIR")" ]; then
    echo -e "${CYAN}[!] There's nothing to delete ^-^${NC}"
    exit 0
fi

echo -e "${BOLD}Available projects for deletion:${NC}"
ls -1 "$WORK_DIR"
echo "------------------------------------------"
read -p "¿Are you sure of deleting everything? [${GREEN}y${NC}/${RED}n${NC}]: " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    rm -rf "$WORK_DIR"/*
    echo "[OK] ${CYAN}Work directories were sucessfully cleaned.${NC}"
else
    echo "[!] ${RED}Operation aborted${NC}"
fi

}

print_menu
