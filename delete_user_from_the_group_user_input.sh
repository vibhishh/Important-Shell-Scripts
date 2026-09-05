#!/bin/bash

read -p "Enter username: " USER
read -p "Enter group name: " GROUP

# Check user
if ! id "$USER" &>/dev/null; then
    echo "ERROR: User '$USER' does not exist"
    exit 1
fi

# Check group
if ! getent group "$GROUP" &>/dev/null; then
    echo "ERROR: Group '$GROUP' does not exist"
    exit 1
fi

# Remove user from group
if gpasswd -d "$USER" "$GROUP" &>/dev/null; then
    echo "SUCCESS: $USER removed from $GROUP"
else
    echo "WARNING: Could not remove $USER from $GROUP"
fi

# Delete user and home directory
if userdel -r "$USER"; then
    echo "SUCCESS: User '$USER' deleted"
else
    echo "ERROR: Failed to delete user '$USER'"
    exit 1
fi

echo "Completed."
