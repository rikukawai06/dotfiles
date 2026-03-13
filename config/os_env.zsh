if [[ "$(uname)" == "Darwin" ]]; then
  # Mac用の処理（Homebrewのインストールなど）
  export OS_ENV="mac"
elif [[ "$(uname -r)" == *microsoft* ]] || [[ "$(uname -r)" == *WSL* ]]; then
  # windows用の処理
  export OS_ENV="windows"
fi