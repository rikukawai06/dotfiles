# ==========================================
# 1. Homebrew のパス設定 (Mac / WSL 両対応)
# ==========================================
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac (Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
elif [[ "$(uname)" == "Linux" ]]; then
  # WSL2 (Linux)
  if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

if [[ "$(uname -r)" == *microsoft* ]] || [[ "$(uname -r)" == *WSL* ]]; then
  # 1. whichで探して WINGET_PATH に代入
  export WINGET_PATH=$(which winget.exe 2> /dev/null)
  
  # 2. 見つからなかった場合のフォールバック（予備）パス
  if [[ -z "$WINGET_PATH" ]]; then
    export WINGET_PATH="/mnt/c/Windows/System32/winget.exe"
    # ※通常wingetは以下の場所にあることが多いので、もし動かなければこちらを試してください
    # export WINGET_PATH="/mnt/c/Users/$(cmd.exe /c echo %USERNAME% 2>/dev/null | tr -d '\r')/AppData/Local/Microsoft/WindowsApps/winget.exe"
  fi
fi