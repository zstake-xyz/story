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

# Function to update Story to the latest version
Cosmovisor_story() {
    wget https://raw.githubusercontent.com/zstake-xyz/story/refs/heads/main/Cosmovisor_story
    python3 Cosmovisor_story
}

# Display menu and prompt user for input
echo "Story Protocol 자동 설치 프로그램에 오신 것을 환영합니다."
echo "1. Odyssey Testnet Validator 설치 "
echo "2. Odyssey 서버 동기화 상태 확인"
echo "3. Odyssey Testnet 최신 버전 업데이트(V0.13.0)"
echo "4. Cosmovisor 자동 업데이트 프로그램 설치"
read -p "원하는 메뉴의 번호를 입력하세요 : " choice

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
    4)
        Cosmovisor_story
        ;;
    *)
        echo "잘못된 선택입니다. 올바른 번호를 입력하세요"
        ;;
esac
