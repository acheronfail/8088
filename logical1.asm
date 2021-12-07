  org 0x0100

start:
  mov al, 0x32
  and al, 0x0f

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x2c ; comma
  call display_letter

  mov al, 0x01
  or al, 0x03

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x2c ; comma
  call display_letter

  mov al, 0xfc ; load with -4
  not al

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x2c ; comma
  call display_letter

  mov al, 0xfc ; load with -4
  neg al ; negate  (two's complement)

  add al, 0x30 ; convert to ASCII
  call display_letter
