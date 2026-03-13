# ==========================================
# 1. パス設定 (Mac / WSL 両対応)
# ==========================================

if [[ "$(uname)" == "Darwin" ]]; then
  # Mac用の処理（Homebrewのインストールなど）
  export OS_ENV="mac"
elif [[ "$(uname -r)" == *microsoft* ]] || [[ "$(uname -r)" == *WSL* ]]; then
  # windows用の処理
  export OS_ENV="windows"
fi


if [[ "$(uname)" == "Darwin" ]]; then
  # Mac (Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi