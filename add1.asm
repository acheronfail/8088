  org 0x0100

start:
  mov al, 0x04
  add al, 0x03

  add al, 0x30 ; convert to ASCII digit
  call display_letter
