#!/bin/bash

GROUP="developers"

# Create group if it doesn't exist
if ! getent group "$GROUP" > /dev/null; then
    groupadd "$GROUP"
    echo "Group $GROUP created"
fi

USERS=("user1" "user2")

for USER in "${USERS[@]}"
do
    # Create user if it doesn't exist
    if id "$USER" &>/dev/null; then
        echo "$USER already exists"
    else
        useradd -m "$USER"

        if [ $? -eq 0 ]; then
            echo "$USER created"
        else
            echo "ERROR: Failed to create $USER"
            continue
        fi
    fi

    # Add user to group
    usermod -aG "$GROUP" "$USER"

    if [ $? -eq 0 ]; then
        echo "$USER added to $GROUP"
    else
        echo "ERROR: Failed to add $USER to $GROUP"
    fi
done

echo "Completed."
