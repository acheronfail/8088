; display AX as a decimal number
display_number:
  mov dx, 0
  mov cx, 10
  div cx      ; AX = DX:AX / CX
  push dx
  cmp ax, 0
  je display_number_1
  call display_number

display_number_1:
  pop ax
  add al, '0'   ; convert to ASCII
  call display_letter
  ret
