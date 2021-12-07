int 0x20 ; exit to command line

; Display letter contained in AL (ASCII)
display_letter:
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x0e ; load AH with code for terminal output
  mov bx, 0x000f ; load BH with page zero, and BL with color (graphic mode)
  int 0x10 ; call the BIOS for displaying one letter
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  ret

; Read keyboard into AL (ASCII)
read_keyboard:
  push bx
  push cx
  push dx
  push si
  push di
  mov ah, 0x00 ; load AH with code for keyboard read
  int 0x16 ; call BIOS for reading keyboard
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  ret
