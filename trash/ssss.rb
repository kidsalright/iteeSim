HEIGHT = 30
WIDTH = 80

i = HEIGHT
printf "\033[46m\n"
while i != 0
  printf "%#{WIDTH}s\n", " "
  i -= 1
end
