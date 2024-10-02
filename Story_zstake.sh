#!/bin/bash

# Update package list and install Python3 and pip
sudo apt update
sudo apt install -y python3 python3-pip

# Function to install Story automatically
install_story() {
    wget https://raw.githubusercontent.com/zstake-xyz/story/refs/heads/main/story_installer.sh
    python3 story_installer.sh
}

# Function to check Story node synchronization status
check_story_status() {
    wget https://raw.githubusercontent.com/zstake-xyz/story/refs/heads/main/story_status
    python3 story_status
}

# Function to update Story to the latest version
update_story() {
    wget https://raw.githubusercontent.com/zstake-xyz/story/refs/heads/main/story_update
    python3 story_update
}

# Display menu and prompt user for input
echo "Please select an option:"
echo "1. Install Story automatically"
echo "2. Check Story node synchronization status"
echo "3. Update Story to the latest version"
read -p "Enter the number of your choice: " choice

# Execute the corresponding function based on user input
case $choice in
    1)
        install_story
        ;;
    2)
        check_story_status
        ;;
    3)
        update_story
        ;;
    *)
        echo "Invalid choice. Please run the script again and select a valid option."
        ;;
esac
