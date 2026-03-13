#!/bin/zsh

# clone repository
if [[ ! -e ${HOME}/.dotfiles ]]; then
  git clone https://github.com/rikukawai06/dotfiles.git ${HOME}/.dotfiles
else
  git -C ${HOME}/.dotfiles pull
fi
source ~/.dotfiles/config/os_env.zsh

# link dotfiles
cd ${HOME}/.dotfiles
for name in *; do
  if [[ ${name} != 'setup' ]] && [[ ${name} != 'config' ]] && [[ ${name} != 'README.md' ]]; then
    if [[ -L ${HOME}/.${name} ]]; then
      unlink ${HOME}/.${name}
    fi
    ln -sfv ${PWD}/${name} ${HOME}/.${name}
  fi
done

# link config
if [[ ! -d ${HOME}/.config ]]; then
  mkdir ${HOME}/.config
fi
cd ./config
for name in *; do
  if [[ -L ${XDG_CONFIG_HOME:-$HOME/.config}/$name ]]; then
    unlink ${XDG_CONFIG_HOME:-$HOME/.config}/$name
  fi
  ln -sfv ${PWD}/${name} ${XDG_CONFIG_HOME:-$HOME/.config}/${name}
done

# zplug
if [[ ! -d ${HOME}/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ${HOME}/.zshrc

# windowsに必要なツールをインストール
if [[ "$OS_ENV" == "windows" ]]; then
  echo "WSL環境を検知しました。Windows側にGUIアプリをインストールします..."
  winget.exe install --id Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements
  winget.exe install --id Fork.Fork -e
  winget.exe install --id Docker.DockerDesktop -e --accept-package-agreements --accept-source-agreements
  winget.exe install --id DBeaver.DBeaver.Community -e --accept-package-agreements --accept-source-agreements
fi

# Install brew packages
if [[ "$CI" != "true" ]] && [[ "$OS_ENV" == "mac" ]]; then
  echo "Homebrewパッケージをインストールします..."
  brew bundle --file="${HOME}/.dotfiles/setup/Brewfile"
else
  echo "CI環境のため、brew bundle はスキップします（テスト爆速化）"
fi