#!/bin/bash

git config --global user.name "Mike"
git config --global user.email mike_alias@heins.ca
git config --global core.editor nano
git config --global merge.tool meld
git config --global diff.tool meld

#to use git difftool -d <branch1>..<branch2>
#just type git da <branch1>..<branch2>
git config --global alias.da 'difftool -d'
git config --global alias.graph 'log --graph --all --decorate --color'

git config --global alias.lg1 "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
git config --global alias.lg2 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
git config --global alias.lg !"git lg1"
git config --list
