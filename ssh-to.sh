#!/bin/bash

jordan() {
  ssh deploy@64.227.77.117
}

deploy() {
  echo '----> starting deployment for elahi'
  cap elahi deploy
  echo '----> elahi deployment finished <--------'
}

"$@"

# bash ssh-to.sh b1
# bash ssh-to.sh b2
