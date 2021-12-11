# Standard operations

build-com NAME:
  nasm -f bin {{NAME}}.asm -l {{NAME}}.lst -o {{NAME}}.com

run NAME: (build-com NAME)
  dosbox {{NAME}}.com

build-boot NAME:
  nasm -f bin {{NAME}}.asm -l {{NAME}}.lst -o {{NAME}}.img

boot NAME: (build-boot NAME)
  qemu-system-x86_64 -drive format=raw,file={{NAME}}.img

# Operations using library1.asm

build1 NAME:
  cat {{NAME}}.asm > main.asm
  cat library1.asm >> main.asm
  just build-com main

run1 NAME: (build1 NAME)
  just run main

# Operations using library1.asm and library2.asm

build2 NAME:
  cat {{NAME}}.asm > main.asm
  cat library1.asm library2.asm >> main.asm
  just build-com main

run2 NAME: (build2 NAME)
  just run main
