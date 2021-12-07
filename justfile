# Standard operations

build NAME:
  nasm -f bin {{NAME}}.asm -l {{NAME}}.lst -o {{NAME}}.com

run NAME: (build NAME)
  dosbox {{NAME}}.com

# Operations using library1.asm

build1 NAME:
  cat {{NAME}}.asm > main.asm
  cat library1.asm >> main.asm
  just build main

run1 NAME: (build1 NAME)
  just run main

# Operations using library1.asm and library2.asm

build2 NAME:
  cat {{NAME}}.asm > main.asm
  cat library1.asm library2.asm >> main.asm
  just build main

run2 NAME: (build2 NAME)
  just run main
