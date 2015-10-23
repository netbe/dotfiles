#!/bin/bash

echo "Installing Scripts/hide_simulator.scpt"

read -d '' HIDE_SIMULATOR <<EOF
<dict>
    <key>Xcode.Alert.RunScript</key>
    <dict>
        <key>enabled</key>
        <true/>
        <key>path</key>
        <string>$PWD/hide_simulator.scpt</string>
    </dict>
</dict>
EOF

defaults write com.apple.dt.Xcode "Xcode.AlertEvents.4_1" -dict-add "Xcode.AlertEvent.TestingGeneratesOutput" "$HIDE_SIMULATOR"
defaults write com.apple.dt.Xcode "Xcode.AlertEvents" -dict-add "Xcode.AlertEvent.TestingGeneratesOutput" "$HIDE_SIMULATOR"

echo "\nPlease Restart Xcode"
