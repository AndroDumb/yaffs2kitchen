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

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"

# set permissions
chmod +x "$SCRIPTS_DIR"/*.sh 2>/dev/null

print_menu() {
while true; do
    clear
    echo -e "${LIME}==========================================${NC}"
    echo -e "${YELLOW}               YAFFS2Kitchen       ${NC}"
    echo -e "${PURPLE}               by @AndroDumb       ${NC}"
    echo -e "${LIME}==========================================${NC}"
    echo "  [1] Unpack images (.img)"
    echo "  [2] Repack images (.img)"
    echo "  [3] Clean work directory"
    echo -e "  [4] ${RED}Exit${NC}"
    echo "${LIME}==========================================${NC}"
    read -p "${BLUE}Select an option [1-4]: ${NC}" option
    
    

    case $option in
        1)
            clear
            echo ""
            "$SCRIPTS_DIR/unpack.sh"
            read -p "${CYAN}Press enter to continue...${NC}"
            ;;
        2)
            clear
            echo ""
            "$SCRIPTS_DIR/repack.sh"
            read -p "${CYAN}Press enter to continue...${NC}"
            ;;
        3)
            clear
            echo ""
            "$SCRIPTS_DIR/clean_work.sh"
            read -p "${CYAN}Press enter to continue...${NC}"
            ;;
        4)
            clear
            echo -e "${LIGHT_GRAY}\nExiting...${NC}"
            clear
            exit 0
            ;;
        *)
            echo -e "${RED}\n[!] Inavlid option.${NC}"
            sleep 1
            ;;
    esac
done
}

print_menu
