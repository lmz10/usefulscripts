#!/bin/bash

echo "--- Starting Universal Server Setup ---"

# 1. Detect OS and Update/Install core packages
if [ -f /etc/debian_version ]; then
    echo "Detected Debian/Ubuntu system..."
    sudo apt update && sudo apt upgrade -y
    # Install Java, Screen, and Tmux
    sudo apt install openjdk-21-jdk screen tmux -y
    FIREWALL_TYPE="ufw"
elif [ -f /etc/redhat-release ] || [ -f /etc/oracle-release ]; then
    echo "Detected RHEL/Oracle/CentOS system..."
    sudo dnf update -y
    # Install Java, Screen, and Tmux
    sudo dnf install java-21-openjdk screen tmux -y
    FIREWALL_TYPE="firewalld"
else
    echo "Unknown OS. Attempting generic install..."
    sudo yum update -y && sudo yum install java-21-openjdk screen tmux -y
    FIREWALL_TYPE="firewalld"
fi

# 2. Configure Firewall (Port 25565)
echo "Configuring Firewall..."
if [ "$FIREWALL_TYPE" == "firewalld" ]; then
    sudo firewall-cmd --permanent --zone=public --add-port=25565/tcp
    sudo firewall-cmd --permanent --zone=public --add-port=25565/udp
    sudo firewall-cmd --reload
elif [ "$FIREWALL_TYPE" == "ufw" ]; then
    sudo ufw allow 25565/tcp
    sudo ufw allow 25565/udp
    sudo ufw reload
fi

# 3. Final Verification
echo "--- Installation Complete! ---"
echo "Java Version: $(java -version 2>&1 | head -n 1)"
echo "Screen Version: $(screen -v | cut -d' ' -f3)"
echo "Tmux Version: $(tmux -V)"
echo "--- Ready to play! ---"
