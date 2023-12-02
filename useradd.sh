#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run the script as root or with sudo."
  exit 1
fi

# Prompt the user for first and last names
read -p "Enter first name: " first_name
read -p "Enter last name: " last_name

# Check if the first and last names are provided
if [ -z "$first_name" ] || [ -z "$last_name" ]; then
  echo "Error: First name and last name are required."
  exit 1
fi

# Generate username and password
password="${first_name,,}${last_name,,}"  # Concatenate lowercased first name and last name
username="${first_name:0:1}${last_name}"  # Use the first name initial plus last name as the password

# Check if the username is already taken
if id "$username" &>/dev/null; then
  echo "Error: User '$username' already exists. Please choose a different first and last name."
  exit 1
fi

# Create user with password
useradd -m -s /bin/bash "$username"
echo "$username:$password" | chpasswd

echo "User '$username' created with password '$password'."

### This is beautiully put together by bmbah
