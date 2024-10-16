#!/bin/bash

cat << "EOF"
#      .___    _____   ________             _______              ____   __    
#    __| _/   /  |  |  \_____  \    _____   \   _  \     ____   /_   | |  | __
#   / __ |   /   |  |_   _(__  <   /     \  /  /_\  \   /    \   |   | |  |/ /
#  / /_/ |  /    ^   /  /       \ |  Y Y  \ \  \_/   \ |   |  \  |   | |    < 
#  \____ |  \____   |  /______  / |__|_|  /  \_____  / |___|  /  |___| |__|_ \
#       \/       |__|         \/        \/         \/       \/              \/
EOF
sleep 1
echo
echo

#Script Startup
string='Starting steamtinkerlaunch dependency check...
'
for ((i=0; i<=${#string}; i++)); do
    printf '%s' "${string:$i:1}"
    sleep 0.$(( (RANDOM % 5) + 1 ))
done 

# Check for required dependencies and install if missing
dependencies=(git glib2-devel libtool autoconf automake intltool gtk3-devel make gcc gcc-c++ xdotool unzip procps-ng wget xprop xrandr xxd xwininfo gawk)

for package in "${dependencies[@]}"; do
    if ! rpm -q "$package" &> /dev/null; then
        echo "$package is missing, installing..."
        sudo dnf install -y "$package"
    else
        echo "$package: found"
    fi
done

# Function to compare yad versions
version_check() {
    installed_version=$(yad --version 2>/dev/null || echo "0")
    required_version="7.2"
    
    if [ "$(printf '%s\n' "$required_version" "$installed_version" | sort -V | head -n1)" = "$installed_version" ] && [ "$installed_version" != "$required_version" ]; then
        return 1 # yad is old or not installed
    else
        return 0 # yad is up-to-date
    fi
}

# Check if yad is installed and up-to-date
if version_check; then
    echo "yad is up-to-date, skipping build..."
else
    echo "yad is missing or outdated, building from source..."

    # Clone the yad repository
    git clone https://github.com/v1cont/yad.git yad-dialog-code

    # Change to the cloned directory
    cd yad-dialog-code || echo "yad directory not found, or permissions are borked!" exit 1

    # Prepare the build environment and configure the project
    autoreconf -ivf && intltoolize

    # Compile the code
    ./configure && make

    # Install the compiled program
    sudo make install
fi

# Update the GTK icon cache
gtk-update-icon-cache

echo "Installation complete. Re-launch ProtonUp and attempt steamtinkerlaunch installation..."
exit 0
