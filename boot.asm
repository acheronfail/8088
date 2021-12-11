  org 0x7c00  ; first sector of floppy disk inside ram

start:
  push cs     ; assumes CS contains 0x0000
  pop ds
  mov bx, string

; repeat until string is printed
repeat:
  mov al, [bx]
  test al, al
  je end

  push bx
  mov ah, 0x0e
  mov bx, 0x000f
  int 0x10
  pop bx
  inc bx
  jmp repeat

end:
  jmp $         ; (inf-loop): jump over itself ($ gives current address)

string:
  db "Hello, World", 0
  times 510-($-$$) db 0   ; fill boot sector with "0"s (510 bytes)
  db 0x55, 0xaa           ; magic signature so BIOS detects this as bootable
