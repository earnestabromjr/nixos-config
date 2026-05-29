set positional-arguments

@git target:
  git add .
  git commit -m {{target}}
