  org 0x0100

  ; Setup text 80x25 mode color
  mov ax, 0x0002
  int 0x10

  mov ax, 0xb800  ; segment for video data
  mov ds, ax      ; ...load into DS
  mov es, ax      ; ...load into DS

main_loop:
  ; read clock from BIOS
  mov ah, 0x00
  int 0x1a

  mov al, dl
  test al, 0x40   ; Is bit 6 "1"?
  je m2           ; No, so jump
  not al          ; complement bits for reverse effect
m2:
  and al, 0x3f    ; separate lower 6 bits
  sub al, 0x20    ; make it -32 to +31
  cbw             ; extend to word
  mov cx, ax      ; save in cx

  mov di, 0x0000  ; Point to the screen
  mov dh, 0       ; Row
m0:
  mov dl, 0       ; Column
m1:
  push dx         ; Save DX (DH and DL)
  mov bx, sin_table
  mov al, dh      ; Take the row
  shl al, 1       ; Multiply by 2 (because aspect ratio)
  and al, 0x3f    ; Limit to 0-63
  cs xlat         ; Extract sin value (`xlat` performs `mov AL, [BX + AL]`)
  cbw             ; Extend to 16 bits
  push ax         ; Save in stack
  mov al, dl      ; Take the column
  and al, 0x3f    ; Limit to 0-63
  cs xlat         ; Extract sin value
  cbw             ; Extend to 16 bits
  pop dx
  add ax, dx      ; Add with previous sin
  add ax, cx      ; Add with clock time
  mov ah, al      ; Use as color background/foreground
  mov al, 0x2a    ; Use asterisk as letter
  mov [di], ax    ; Put in display (word)
  add di, 2       ; Go to next letter (word)
  pop dx          ; Restore DX
  inc dl          ; Increment column
  cmp dl, 80      ; Reached 80 columns?
  jne m1          ; No, jump
  inc dh          ; Increment row
  cmp dh, 25      ; Reached 25 rows?
  jne m0          ; No, jump
  mov ah, 0x01    ; BIOS service. Get keyboard state
  int 0x16        ; Call BIOS
  jne key_pressed ; Jump if key pressed.
  jmp main_loop   ; Repeat
key_pressed:
  int 0x20        ; Exit to command-line

;
; Sin table of 360 degrees in 64 bytes
; Also -1.0 is -64 and +1.0 is 64
;
sin_table:
  db   0,   6,  12,  19,  24,  30, 36,  41
  db  45,  49,  53,  56,  59,  61, 63,  64
  db  64,  64,  63,  61,  59,  56, 53,  49
  db  45,  41,  36,  30,  24,  19, 12,   6
  db   0,  -6, -12, -19, -24, -30, -36, -41
  db -45, -49, -53, -56, -59, -61, -63, -64
  db -64, -64, -63, -61, -59, -56, -53, -49
  db -45, -41, -36, -30, -24, -19, -12,  -6
