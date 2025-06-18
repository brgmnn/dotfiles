#!/bin/bash

# Dock
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock showhidden -bool false

# Keyboard


# Restart items
killall Dock
killall Finder
killall SystemUIServer
killall NotificationCenter
