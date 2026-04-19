#!/bin/bash

# =================================================================
# Project: H-Robot Environment Setup
# Author: ha-le
# Purpose: Automate directory, group, and permission management
# =================================================================

# 1.Define Variables
PROJECT_DIR="/opt/h-robot"
TEAM_GROUP="robotics-team"
ADMIN_USER="ha-le"
DEV_USER="ha-le-1"
VIEWER_USER="ha-le-2"

echo "[1/5] Creating groups and users..."
sudo groupadd $TEAM_GROUP 2>/dev/null
# Add users if they don't exist
for user in $ADMIN_USER $DEV_USER $VIEWER_USER; do
	sudo adduser --disabled-password --gecos "" $user 2>/dev/null
	sudo usermod -aG $TEAM_GROUP $user
done


echo "[2/5] Setting up directory structure..."
sudo mkdir -p $PROJECT_DIR
sudo chown $ADMIN_USER:$TEAM_GROUP $PROJECT_DIR

echo "[3/5] Applying Permissions (Standard & Sticky Bit)..."
# Owner: rwx, GRoup:rx, Others: --- + Sticky Bit
sudo chmod 1750 $PROJECT_DIR

echo "[4/5] Applying Advanced ACLs..."
# Ensure ha-le-1 has full access, and new fies inherit group access
sudo setfacl -m u:$DEV_USER:rwx $PROJECT_DIR
sudo setfacl -d -m g:$TEAM_GROUP:rx $PROJECT_DIR
sudo setfacl -d -m u:$DEV_USER:rwx $PROJECT_DIR

echo "[5/5] Creating a test file..."
sudo -u $ADMIN_USER touch "$PROJECT_DIR/main_core.py"
echo "print('H-Robot System Online')" | sudo tee "$PROJECT_DIR/main_core.py" > /dev/null

echo "-----------------------------------------------------"
echo "SETUP COMPLETE!"
echo "Permissions View:"
ls -ld $PROJECT_DIR
getfacl $PROJECT_DIR
