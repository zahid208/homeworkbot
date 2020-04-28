#!/bin/bash

jordan() {
  ssh deploy@159.65.164.59
}

deploy() {
  echo '----> starting deployment for elahi'
  cap jordan deploy
  echo '----> elahi deployment finished <--------'
}

"$@"

# bash ssh-to.sh b1
# bash ssh-to.sh b2
