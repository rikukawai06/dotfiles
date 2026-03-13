#!/bin/zsh

source ~/.dotfiles/config/os_env.zsh

echo "=== dotfilesのアンインストールを開始します ==="

# Windows側のツールをアンインストール (WSL環境のみ)
if [[ "$OS_ENV" == "windows" ]]; then
	echo "Windows側のアプリを削除しています..."
	# installの逆（uninstall）を実行
	winget.exe uninstall --id Microsoft.VisualStudioCode
	winget.exe uninstall --id Fork.Fork
	winget.exe uninstall --id Docker.DockerDesktop
	winget.exe uninstall --id DBeaver.DBeaver.Community
	echo "✔ Windowsツールのアンインストール完了"
fi

# Homebrewパッケージのアンインストールについて（手動推奨）
echo ""
echo "⚠️ 【重要】Homebrewのアプリ（fzf, Chromeなど）は安全のため自動削除していません。"
echo "（※普段使っているアプリまで消してしまう事故を防ぐためです）"
echo "完全に消し去りたい場合は、以下のコマンドをコピーして実行してください："
echo ""
echo "  brew uninstall fzf ghq hub jq neovim"

if [[ "$OS_ENV" == "mac" ]]; then
  echo "  brew uninstall --cask docker google-chrome iterm2 sequel-ace sublime-text visual-studio-code fork notion"
  echo "  mas uninstall 409203825 409201541 497799835"
fi

# ホームディレクトリのシンボリックリンクを解除
if [[ -d ${HOME}/.dotfiles ]]; then
  cd ${HOME}/.dotfiles
  for name in *; do
    if [[ ${name} != 'setup' ]] && [[ ${name} != 'config' ]] && [[ ${name} != 'README.md' ]]; then
      if [[ -L ${HOME}/.${name} ]]; then
        unlink ${HOME}/.${name}
        echo "✔ リンク解除: ${HOME}/.${name}"
      fi
    fi
  done

  # .config 内のシンボリックリンクを解除
  if [[ -d ${HOME}/.dotfiles/config ]]; then
    cd ${HOME}/.dotfiles/config
    for name in *; do
      if [[ -L ${XDG_CONFIG_HOME:-$HOME/.config}/${name} ]]; then
        unlink ${XDG_CONFIG_HOME:-$HOME/.config}/${name}
        echo "✔ リンク解除: ${XDG_CONFIG_HOME:-$HOME/.config}/${name}"
      fi
    done
  fi
else
  echo "⚠️ ${HOME}/.dotfiles が見つかりません。リンク解除をスキップします。"
fi

# zplug の削除
if [[ -d ${HOME}/.zplug ]]; then
	rm -rf ${HOME}/.zplug
	echo "✔ zplug を削除しました: ${HOME}/.zplug"
fi

# リポジトリ本体の削除
cd ${HOME}
rm -rf ${HOME}/.dotfiles
echo "✔ ${HOME}/.dotfiles を完全に削除しました。"
echo "さようなら！👋"


echo "=== アンインストールが完了しました ==="