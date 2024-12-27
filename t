#!/usr/bin/bash

declare -A entries=(
  [chili-stable]='https://repo.chililinux.com/stable/$arch'
  [chili-testing]='https://repo.chililinux.com/testing/$arch'
  [chili-extra]='https://repo.chililinux.com/extra/$arch'
  [community-stable]='https://repo.communitybig.org/stable/$arch'
  [community-testing]='https://repo.communitybig.org/testing/$arch'
  [community-extra]='https://repo.communitybig.org/extra/$arch'
  [biglinux-stable]='https://repo.biglinux.com.br/stable/$arch'
  [biglinux-testing]='https://repo.biglinux.com.br/testing/$arch'
  [vilmar-testing]='https://repo.biglinux.com.br/testing/$arch'
)

for entry in "${!entries[@]}"; do
  section='['"$entry"']'
  server="${entries[$entry]}"

  if ! grep -qF "$section" /etc/pacman.conf; then
    echo -e "\n$section\nSigLevel = PackageRequired\nServer = $server" | \
    sudo tee -a /etc/pacman.conf /etc/chrootbuild/pacman.conf.x86_64 >/dev/null
  fi
done
