#!/bin/bash

sudo pacman -S zsh zsh-autocomplete starship

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s /usr/bin/zsh
