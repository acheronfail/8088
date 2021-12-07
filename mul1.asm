  org 0x100

start:
  mov al, 0x03
  mov cl, 0x02
  mul cl ; multiply AL by CL - result stored in AX
         ; NOTE: for signed multiplication use `imul`

  add al, 0x30 ; convert to ASCII
  call display_letter
