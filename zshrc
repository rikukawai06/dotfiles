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