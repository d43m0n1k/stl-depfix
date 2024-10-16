#stl-depfix-dnf

This script resolves the unmet dependency error for SteamTinkerLaunch in Nobara/Fedora-based systems when using ProtonUp-Qt.
Error addressed:
"You have several unmet dependencies for SteamTinkerLaunch."

What it does:

The script automatically checks for the following dependencies and installs or updates them if missing:

    awk-gawk
    git
    pgrep
    unzip
    wget
    xdotool
    xprop
    xrandr
    xxd
    xwininfo
    yad >= 7.2

Usage:

    Download the script: git clone https://github.com/d43m0n1k/stl-depfix-dnf
    Pop into new dir: cd stl-depfix-dnf
    Make script executable: sudo chmod +x stl-depfix-dnf.sh
    Run it with: bash stl-depfix-dnf.sh

The script will cycle through the required dependencies and ensure they are installed or updated to meet the requirements of SteamTinkerLaunch.
