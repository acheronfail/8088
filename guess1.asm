  org 0x0100

  ; NOTE: call `main.com` from within dosbox multiple times to see
  ;   the number changing

  in al, (0x40)   ; read the timer counter chip
  and al, 0x07    ; mask bits so value is 0..7
  add al, 0x30    ; convert to ASCII
  mov cl, al      ; save AL into CL

game_loop:
  mov al, '?'
  call display_letter
  call read_keyboard
  cmp al, cl    ; AL == CL ?
  jne game_loop
  call display_letter
  mov al, ':'
  call display_letter
  mov al, ')'
  call display_letter
