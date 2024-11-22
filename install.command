#!/usr/bin/osascript

tell application "Terminal"
    activate
    do script "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/louisgavalda/placement/refs/heads/main/install.sh)\""
end tell
