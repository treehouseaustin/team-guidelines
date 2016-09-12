#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
  git clone https://github.com/git/git.git --depth=1
  cp git/contrib/completion/git-prompt.sh ./
  rm -rf git/
  rsync --exclude "git/" --exclude ".DS_Store" --exclude "setup.sh" -av --no-perms . ~
  source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
