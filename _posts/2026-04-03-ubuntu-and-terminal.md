---
layout: post
title: "Ubuntu & Terminal"
date: 2026-04-03
categories: [intro, robotics]
---

This week is all about installing Ubuntu and learning some basic terminal commands.

# My Focus:
* Install Ubuntu 22.04/24.04 (Dual boot).
* Learn navigation commands: pwd, cd, ls, mkdir, rm, cp, mv.
* Manage permissions: chmod, chown, sudo.
* Content editing: touch, cat, nano, grep, echo.
Product: a simple .sh script to automatically create the project directory structure.

<br>
<br>

# A. Installing Ubuntu (Dual Boot)

## 1. Preparation (Windows)
* **Backup:** Sync critical files to an external drive or Cloud.
* **Disable BitLocker:** *Manage Bitlocker* > *Turn off* (wait for decryption).
* **Disable Fast Startup:** Prevents Windows from "locking" the drive.
* **Shrink Volume:** * Open `Disk Management`.
    * Right-click `C:` drive > `Shrink Volume`.
    * Result: **Unallocated Space**.

## 2. Create Bootable USB
* **USB Requirement:** Prepare a USB drive with at least **8GB** capacity. **Warning:** All data on this USB will be erased.
* **Downloads:** [Ubuntu 24.04 LTS](https://ubuntu.com/download/desktop) and [Rufus](https://rufus.ie).
* **Flashing Process:**
    1. **Plug in** your USB drive.
    2. Open **Rufus**.
    3. **Device:** Select your USB.
    4. **Boot selection:** Click `SELECT` and choose the downloaded Ubuntu ISO.
    5. **Partition scheme:** Set to `GPT`.
    6. **Target system:** `UEFI (non CSM)`.
    7. Click `START` and choose the recommended "ISO Image mode".

## 3. BIOS/UEFI Setup
* **Access BIOS:** Restart and tap `F2`, `F10`, or `Del`.
* **SATA Mode:** Switch from RAID/RST to **AHCI** (Crucial for SSD detection).
* **Secure Boot:** Set to **Disabled** if you encounter signature errors.
* **Boot Priority:** 
    1. **Keep the USB plugged in.**
    2. Move USB to the top of the boot order or use the **Boot Menu** (`F12`/`Esc`) during restart.

## 4. Installation Steps
1. **Welcome:** Select **Install Ubuntu**.
2. **Updates:** Choose *Normal Installation* + Check **"Install third-party software..."**.
3. **Installation Type:**
    * **Auto:** Select **"Install Ubuntu alongside Windows Boot Manager"**.
    * **Manual:** Select "Something else" to assign `/` (Root) to the "free space".
4. **Identity:** Set timezone (Ho Chi Minh City) and create your account.
5. **Finish:** Once done, click **Restart Now**. **Remove the USB** only when the screen prompts you to do so.

## 5. Post-Installation
Open Terminal (`Ctrl + Alt + T`) and run:

### Update System
```bash
sudo apt update && sudo apt upgrade -y
```
---
<br>
<br>
<br>

# B. Basic Terminal Commands

## 1. Navigation commands: pwd, cd, ls, mkdir, cp, mv, rm.
### 1.1 The File System Tree
* / : The Root directory (contains the entire operating system).

* ~ : Your Home directory (where your personal data lives).

* . : The Current directory (where you are standing right now).

* ..: The Parent directory (the folder directly above the current one). 

### 1.2 Navigation commands: pwd, cd, ls, mkdir, cp, mv, rm.

### pwd
---
pwd (Print Working Directory): Shows the full path of your current location.

```bash
pwd
```
Result: /home/ha-le

### cd
---
cd (Change Directory): Moves you to a different folder.

```bash
cd Documents
```
Result: ~/Documents$ (Enter Documents)
```bash
cd ..
```
Result: Go up one level (nearest parent folder).
```bash
cd ~
```
Result: Go Home immediately.
```bash
cd -
```
Result: Go back to the previous location.

### ls
---
ls (List): Lists files and directories.

```bash
ls
```
Result: Show names.

```bash
ls -l
```
Result: Show details (permissions, size, date).
```bash
ls -a
```
Result: Show hidden files starting with a dot.
```bash
ls -R
```
Result: Show sub-folders **recursively**.

### mkdir
---
mkdir (Make directory): Create a new directory
-p (Parent): Creates parent folder if they don't exist.

```bash
cd Projects
mkdir Project_A
```
or if Projects folder has not created yet.

```bash
mkdir -p Projects/Project_A
```
### touch
---
touch: Create an empty file.

```bash
touch test_file.txt
```

### cp
---

cp: Copy
<br>
-r (Recursive): **Mandatory** when copying folder.

<br> 
Copy file:
<br>

```bash
cp test_file.txt test_file_copy.txt
```
Copy folder:

```bash
cp -r Project1 Project1_copy
```
### mv
---
mv: Move or Rename

<br>
Move:

```bash
mv test_file.txt Project2/
```
Rename:

```bash
mv test_file.txt test_file_rename.txt
```

### rm
---

rm: Remove (Delete).

-r: Recursive, use for Folder.

-f: Force &ndash; Delete without asking (use with Caution!)

```bash
rm file.txt
```
<br>

```bash
rm -rf Projects
```

## 2. Manage permissions: chmod, chown, sudo.

### chmod
---
chmod (Change Mode): Uses 3 numbers to assign rights to 3 groups: User (Owner) - Group - Others.

**The Point system**
* 4: Read (**r**)
* 2: Write (**w**)
* 1: Execute (**x**)

=> Common Combinations:
- ```chmod 777```:
    - Owner: 7, Group: 7, Others: 7, in which 7 = 4 + 2 + 1.
    - Everyone can do everything.
- ```chmod 755```:
    - Owner: 7 (full rights), group and others: 5 (Read + Execute).
- ```chmod 644```:
    - Owner: 6 (rw), group and others: 4 (r).
- ```chmod 600```:
    - Owner: 6 (rw), group and others have NO access.
- ```chmod +x file.sh```: 
    - Add "execute" permission to Everyone to run the script.
- ```chmod u+x file.sh```:
    - Only user (Owner) is granted permission to execute the file.
- ```chmod g+x file.sh```:
    - Only group members are granted permission to execute the file.
- ```chmod ug+x file.sh```:
    - Both user (owner) and group are granted permission to execute the file.

### chmown
---
chown: Change owner/group

**Syntax**
`sudo chown options user:group file`

**Common Use Cases**

| Goal | Command | Description |
| :--- | :--- | :--- |
| **Change Owner only** | `sudo chown ha-le file.txt` | Only changes the owner to `ha-le`. Group remains unchanged. |
| **Change Group only** | `sudo chown :robotics file.txt` | Owner remains unchanged; only changes the group to `robotics`. |
| **Change Both** | `sudo chown ha-le:robotics file.txt` | Updates the entire "residency" of the file (User and Group). |
| **Recursive Change** | `sudo chown -R ha-le:robotics folder/` | Applies changes to the folder and **all** sub-files/folders inside. |

<br>
<br>

> **Crucial Note:** `chown` only changes **who holds the power** (ownership); it does **not** change **what they can do** (permissions like rwx). To change their allowed actions, you must use it in combination with the `chmod` command.

### sudo

sudo (SuperUser DO): The "Master Key". Put this before any command to run it with Administrator (Root) privileges.

**E.g:**
`sudo apt update`
(Update system software)

---
---

<br>
<br>

**Linux Permissions Cheat Sheet:**

## Linux Permissions & User Management: A Practical Guide

In Linux, everything is a file, and every file is an independent object. Unlike Windows, Linux does **not** have a default inheritance mechanism where a file automatically gets permissions from its parent folder. Instead, we use specific tools to manage access.

---

### 2.1. Key Concepts to Remember
* **The Subject:** Permissions are assigned directly to the **File/Directory**.
* **The Entities:**
    * **User (u):** The owner of the file.
    * **Group (g):** A set of users who share access.
    * **Others (o):** Everyone else on the system.
* **Sticky Bit (`+t`):** Prevents users from deleting or renaming files owned by others within a shared directory.
* **ACL (Access Control Lists):** Allows you to assign permissions to multiple users or groups on a single file.
* **Default ACL:** A template that forces new files created inside a folder to inherit specific permissions (simulating inheritance).

---

### 2.2. Lab Exercise: Managing the "H-Robot" Project

### **Scenario**
You are the lead developer. You need to set up a shared environment for your team:
- **ha-le**: Project Owner (Admin).
- **ha-le-1**: Senior Developer (Needs Read/Write/Execute access).
- **ha-le-2**: Junior Viewer (Needs Read/Execute access only).

### **Phase 1: Setup Users and Groups**
Run these commands as a sudoer:

```bash
# Create the project group
sudo groupadd robotics-team

# Create users
sudo adduser ha-le
sudo adduser ha-le-1
sudo adduser ha-le-2

# Add users to the group
sudo usermod -aG robotics-team ha-le
sudo usermod -aG robotics-team ha-le-1
sudo usermod -aG robotics-team ha-le-2
```
### **Phase 2: Establish the Project Directory**

```bash
# Create a shared directory
sudo mkdir -p /opt/h-robot

# Set ownership
sudo chown ha-le:robotics-team /opt/h-robot

# Set basic permissions (Owner: Full, Group: RX, Others: None)
sudo chmod 750 /opt/h-robot
```

### **Phase 3: Advanced Permissions (The "Pro" Way)**

```bash
# 1. Enable Sticky Bit (No one can delete each other's work)
sudo chmod +t /opt/h-robot

# 2. Grant ha-le-1 special Write access using ACL
sudo setfacl -m u:ha-le-1:rwx /opt/h-robot

# 3. Set Default ACL for "Inheritance"
# This ensures every NEW file automatically gives access to the team
sudo setfacl -d -m g:robotics-team:rx /opt/h-robot
sudo setfacl -d -m u:ha-le-1:rwx /opt/h-robot
```

### **Phase 4: Testing the Permission Matrix**

| User | Action | Expected Result | Why? |
| :--- | :--- | :--- | :--- |
| **ha-le** | Create/Delete any file | **Success ✅** | Owner of the directory. |
| **ha-le-1** | Edit `ha-le`'s files | **Success ✅** | Granted `rwx` via ACL. |
| **ha-le-1** | Delete `ha-le`'s files | **Failed ❌** | Protected by **Sticky Bit**. |
| **ha-le-2** | Edit any file | **Failed ❌** | Group permission is only `rx`. |
| **ha-le-2** | View files | **Success ✅** | Group member. |

<br>

## **Useful Cheat Sheet Commands**

| Command | Description | Example |
| :--- | :--- | :--- |
| `ls -l` | View standard permissions, owner, and group | `ls -l /opt/h-robot` |
| `getfacl` | View detailed ACL and Sticky Bit info | `getfacl script.py` |
| `chmod` | Change file/directory permissions | `chmod 755 script.py` |
| `chown` | Change owner and/or group | `sudo chown ha-le:robotics file.txt` |
| `chgrp` | Change group ownership only | `sudo chgrp robotics file.txt` |
| `setfacl` | Set/modify Access Control Lists (Advanced) | `setfacl -m u:user:rwx file` |
| `umask` | View or set default file creation mask | `umask 022` |
| `chmod +t` | Enable **Sticky Bit** (Prevent deletion by others) | `chmod +t shared_folder/` |

<br>

## 3. Content editing: touch, cat, nano, grep, echo.

### cat
---

cat: Prints the entire file content to the screen.

**E,g:**
`cat file1.txt`

### nano
---

nano: Opens a simple text editor inside terminal.

**E.g:**
`nano script1.sh`

Save: Ctrl + O -> Enter
Exit: CTrl + X

### grep
---

grep: Search for a specific keyword inside a file.

**E.g:**
`grep "Error" server.log`
(Only show lines containing "Error")

### echo
---

echo: Prints text to the screen or pushes it into a file.

Print text: `echo "Hello H-Robot` -> Displays the string on the terminal.

Create/Write to File: `echo "content" > file.txt` -> Creates a new file (or overwrites) with the given text.

Append to file: `echo "a new line" >> file.txt` -> Adds text to the end of an existing file.

Check Variables: `echo $USER` -> Displays the value of an environment variable (e.g., your username).


## Magic operators (symbols)

**>** (Redirect): Writes output to a file (Overwrites old content).

**>>** (Append): Writes output to the end of a file (Keeps old content).

**|** (Pipe): Takes the output of the left command and feeds it to the right command.

**\*** (All): Represents "everything" or "any character".


<br>


## 4. Practice: 
---
Create a simple .sh script to automatically create the project directory structure, assign permissions to the files and test user/group/others access. (Prep: create some users, groups)

**🛠️ H-Robot Environment Setup Script**

Save the following code as setup_hrobot.sh.

```bash
#!/bin/bash

# =================================================================
# Project: H-Robot Environment Setup
# Author: ha-le
# Purpose: Automate directory, group, and permission management
# =================================================================

# 1. Define Variables
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
# Owner: rwx, Group: r-x, Others: --- + Sticky Bit
sudo chmod 1750 $PROJECT_DIR

echo "[4/5] Applying Advanced ACLs..."
# Ensure ha-le-1 has full access, and new files inherit group access
sudo setfacl -m u:$DEV_USER:rwx $PROJECT_DIR
sudo setfacl -d -m g:$TEAM_GROUP:rx $PROJECT_DIR
sudo setfacl -d -m u:$DEV_USER:rwx $PROJECT_DIR

echo "[5/5] Creating a test file..."
sudo -u $ADMIN_USER touch "$PROJECT_DIR/main_core.py"
echo "print('H-Robot System Online')" | sudo tee "$PROJECT_DIR/main_core.py" > /dev/null

echo "---------------------------------------------------"
echo "SETUP COMPLETE!"
echo "Project Directory: $PROJECT_DIR"
echo "Permissions View:"
ls -ld $PROJECT_DIR
getfacl $PROJECT_DIR
```

**🧪 How to run and test**

1. Run the script

Give it execution rights and run it with `sudo`:

```bash
chmod +x setup_hrobot.sh
sudo ./setup_hrobot.sh
```

2. Test the Access Matrix

You can use `sudo -u [user] [command]` to simulate being another user without logging out.

| Test Case | Command | Expected Result |
| :--- | :--- | :--- |
| **Admin Read/Write** | `sudo -u ha-le touch /opt/h-robot/test.txt` | **Success ✅** |
| **Dev Edit Admin File** | <code>echo "# Update" \| sudo -u ha-le-1 tee -a /opt/h-robot/main_core.py</code> | **Success ✅** (ACL works) |
| **Dev Delete Admin File** | `sudo -u ha-le-1 rm /opt/h-robot/main_core.py` | **Denied 🚫** (Sticky Bit works) |
| **Viewer Edit File** | <code>echo "Hack" \| sudo -u ha-le-2 tee /opt/h-robot/main_core.py</code> | **Denied 🚫** (Permission denied) |


Now, try run `python3 /opt/h-robot/main_core.py`

The detailed source code is available on GitHub:
[setup_hrobot.sh](https://github.com/hale84/hale84.github.io/blob/main/linux_exercises/setup_hrobot.sh)


# DONE!!!