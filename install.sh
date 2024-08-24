#!/bin/bash
echo -ne "

██╗  ██╗███████╗██████╗ ███╗   ██╗ █████╗ ██╗         ███████╗███████╗████████╗██╗   ██╗██████╗ 
██║ ██╔╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║         ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
█████╔╝ █████╗  ██████╔╝██╔██╗ ██║███████║██║         ███████╗█████╗     ██║   ██║   ██║██████╔╝
██╔═██╗ ██╔══╝  ██╔══██╗██║╚██╗██║██╔══██║██║         ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║  ██╗███████╗██║  ██║██║ ╚████║██║  ██║███████╗    ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
                                                                                                
"
# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print warning message and get user confirmation
print_warning() {
    echo -e "${YELLOW}Warning: This script will install the Linux LTS kernel and remove the Linux Zen kernel if it is installed.${NC}"
    echo -e "${YELLOW}Please ensure that you have backed up important data before proceeding.${NC}"
    
    # Prompt user for confirmation
    read -p "Do you want to continue? [yes/no]: " response
    case "$response" in
        [yY][eE][sS])
            # Continue with the script
            echo -e "${GREEN}Proceeding with the installation.${NC}"
            ;;
        [nN][oO])
            # Exit the script
            echo -e "${RED}Aborting the script.${NC}"
            exit 1
            ;;
        *)
            # Invalid input
            echo -e "${RED}Invalid response. Please enter 'yes' or 'no'.${NC}"
            exit 1
            ;;
    esac
}

# Function to check if a package is installed
is_installed() {
    pacman -Q "$1" &>/dev/null
}

# Function to install Linux LTS kernel
install_linux_lts() {
    echo -e "${GREEN}Installing Linux LTS kernel...${NC}"
    sudo pacman -S --noconfirm linux-lts
}

# Function to remove Linux Zen kernel
remove_linux_zen() {
    echo -e "${RED}Removing Linux Zen kernel...${NC}"
    sudo pacman -Rns --noconfirm linux-zen
}

# Function to print final instructions
print_instructions() {
    echo -e "${GREEN}The Linux LTS kernel has been installed.${NC}"
    echo -e "${RED}If the Linux Zen kernel was installed, it has been removed.${NC}"
    echo -e "${GREEN}Please select the Linux LTS kernel in the GRUB menu at boot time.${NC}"
    echo -e "${YELLOW}After selecting Linux LTS in GRUB, please reboot your system.${NC}"
}

# Main script execution
print_warning

# Check if linux-zen is installed
if is_installed linux-zen; then
    install_linux_lts
    remove_linux_zen
else
    install_linux_lts
    echo -e "${GREEN}Linux Zen kernel is not installed, only Linux LTS has been installed.${NC}"
fi

print_instructions

