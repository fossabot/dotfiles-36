#!/bin/bash

echo "${0} ..."

# --- Upgrade(brew cask file)
brew cask upgrade

# --- Install(brew cask file)
brew cask install $(grep -v -e '^$' -e '^#' $(dirname ${0})/brewcask.txt)

# --- Delete Cache(all brew cask file)
brew cask cleanup

echo '---------------------------------------->>(EOF)'
