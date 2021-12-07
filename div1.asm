  org 0x0100

start:
  mov ax, 0x64 ; 100
  mov cl, 0x21 ; 33
  div cl ; divide AX by CL - AL=result, AH=remainder
         ; NOTE: for signed division, use `idiv`

  add al, 0x30 ; convert to ASCII
  call display_letter ; displays "3"
  mov al, ah
  add al, 0x30
  call display_letter ; displays "1" (remainder)
