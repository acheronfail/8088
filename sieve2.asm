  org 0x0100

table:      equ 0x8000
table_size: equ 1000

start:
  mov bx, table
  mov cx, table_size
  mov al, 0

p1:
  mov [bx], al    ; write AL into address pointed by BX
  inc bx
  loop p1         ; decrease CX, jump if non-zero
  mov ax, 2       ; start at number 2

p2:
  mov bx, table
  add bx, ax
  cmp byte [bx], 0  ; is it prime? (`byte` means do 8bit cmp not 16bit)
  jne p3

  push ax
  call display_number
  mov al, 0x0d ; \r
  call display_letter
  mov al, 0x0a ; \n
  call display_letter
  pop ax

  mov bx, table
  add bx, ax

p4:
  add bx, ax
  cmp bx, table + table_size
  jnc p3      ; jump if not carry (ie: L >= R)
  mov byte [bx], 1
  jmp p4

p3:
  inc ax
  cmp ax, table_size
  jne p2
