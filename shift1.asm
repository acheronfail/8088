  org 0x0100

start:
  mov al, 0x02
  shl al, 1 ; bit coming out of left is stored in carry

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x0a ; return char
  call display_letter

  mov al, 0x03
  shr al, 1 ; bit going through right is stored in carry

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x0a ; return char
  call display_letter

  mov al, 0x03
  sar al, 1 ; bit introduced on left is copy of original
            ; think of it like: `sar` is >> for signed ints in C
            ;                   `shr` is >> for unsigned ints in C

  add al, 0x30 ; convert to ASCII
  call display_letter
  mov al, 0x0a ; return char
  call display_letter
