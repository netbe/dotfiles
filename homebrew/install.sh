#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" > /tmp/homebrew-install.log
fi

# Install homebrew packages
brew install grc coreutils spark
# Others
brew install gibo # A shell script for easily accessing gitignore boilerplates
brew install ghi # GitHub Issues on the command line. Use your $EDITOR, not your browser.
brew install xctool # command to build xcode project
brew install tig # git overview
brew install wget
exit 0
