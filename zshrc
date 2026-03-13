# ==========================================
# 1. パス設定 (Mac / WSL 両対応)
# ==========================================
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac (Apple Silicon)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi