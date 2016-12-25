#!/usr/bin/bash

case $input in
  hello)
    echo "You said hello"
  ;;
  bye)
    echo "You said bye"
    if foo; then
      bar
    fi
  ;;
  *)
    echo "You said something weird..."
  ;;
esac
