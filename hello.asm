  org 0x0100

  mov ax, 0x0002  ; setup text 80x25 mode color
  int 0x10        ; call bios

  mov ax, 0xb800  ; segment for video data
  mov ds, ax      ; ...load into DS
  mov es, ax      ; ...load into DS

  cld ; clear direction bit, since `stosw` acts differently when it's set
  xor di, di ; clear di (`stosw` uses it for addressing)

  mov ax, 0x1a48 ; AH=bg:blue;fg:lightgreen  AL=H
  stosw
  mov ax, 0x1b45 ; AH=bg:blue;fg:lightaqua   AL=E
  stosw
  mov ax, 0x1c4c ; AH=bg:blue;fg:lightred    AL=L
  stosw
  mov ax, 0x1d4c ; AH=bg:blue;fg:lightpurple AL=L
  stosw
  mov ax, 0x1e4f ; AH=bg:blue;fg:lightyellow AL=0
  stosw

  int 0x20
