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

# brew sources
brew tap thoughtbot/formulae
# Install homebrew packages
brew install grc coreutils spark
# Others
brew install tig # git overview
brew install wget
brew install rbenv # ruby manager
brew install kylef/formulae/swiftenv # swift version manager
brew install xcenv
brew install gibo # A shell script for easily accessing gitignore boilerplates
brew install ghi # GitHub Issues on the command line. Use your $EDITOR, not your browser.

exit 0
