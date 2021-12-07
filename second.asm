  org 0x0100

start:
  mov ah, 0x00 ; keyboard read
  int 0x16

  cmp al, 0x1b ; check for ESC key
  je exit_to_command_line

  mov ah, 0x0e
  mov bx, 0x000f
  int 0x10
  jmp start

exit_to_command_line:
  int 0x20
