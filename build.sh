#!/bin/bash

USER_NAME=$(id -un)
USER_ID=$(id -u)

docker build \
  --build-arg USER_NAME="$USER_NAME" \
  --build-arg USER_ID="$USER_ID" \
  -t hotbitbox/git .

  if grep -q "alias git=" ~/.bash_aliases 2>/dev/null; then
    # Remove existing git alias
    sed -i '/alias git=/,/^alias /{//!d;}; /alias git=/d' ~/.bash_aliases
    echo "Removed existing git alias from ~/.bash_aliases"
  fi

  echo "alias git='docker run --rm -it \\
    -v \$HOME:/home/\$(id -un) \\
    -v \$(pwd):/repo \\
    -u \$(id -u):\$(id -g) \\
    hotbitbox/git'" >> ~/.bash_aliases
  echo "Added git alias to ~/.bash_aliases"