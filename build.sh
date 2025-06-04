#!/bin/bash

# Default alias name is 'git' if not provided as first parameter
ALIAS_NAME="${1:-git}"

USER_NAME=$(id -un)
USER_ID=$(id -u)

docker build \
  --build-arg USER_NAME="$USER_NAME" \
  --build-arg USER_ID="$USER_ID" \
  -t hotbitbox/git .

  if grep -q "alias $ALIAS_NAME=" ~/.bash_aliases 2>/dev/null; then
    # Remove existing alias
    sed -i "/alias $ALIAS_NAME=/,/^alias /{//!d;}; /alias $ALIAS_NAME=/d" ~/.bash_aliases
    echo "Removed existing $ALIAS_NAME alias from ~/.bash_aliases"
  fi

  echo "alias $ALIAS_NAME='docker run --rm -it \\
    -v \$HOME:/home/\$(id -un) \\
    -v \$(pwd):/repo \\
    -u \$(id -u):\$(id -g) \\
    hotbitbox/git'" >> ~/.bash_aliases
  echo "Added $ALIAS_NAME alias to ~/.bash_aliases"