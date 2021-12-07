  org 0x0100

start:
  mov al, 0x30

count1:
  call display_letter
  push ax ; need to save and restore AX since we `cmp` after this
  mov al, 0x2c ; comma
  call display_letter
  pop ax
  inc al
  cmp al, 0x39
  jne count1

count2:
  call display_letter
  push ax
  mov al, 0x2c ; comma
  call display_letter
  pop ax
  dec al
  cmp al, 0x30
  jne count2
