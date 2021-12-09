  org 0x0100

board: equ 0x0300

start:
  mov bx, board
  mov cx, 9
  mov al, '1'

; initialises the board to [0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39]
; which is the ASCII representation of 1-9
board_init:
  mov [bx], al    ; save it into square (one byte)
  inc al          ; increase AL (gives us next digit)
  inc bx          ; increase direction
  loop board_init ; decrement CX, jump if non-zero

game_loop:
  call show_board
  call find_line

  ; "X"'s turn
  call get_movement
  mov byte [bx], 'X'

  call show_board
  call find_line

  ; "O"'s turn
  call get_movement
  mov byte [bx], 'O'

  jmp game_loop

get_movement:
  call read_keyboard
  cmp al, 0x1b ; ESC
  je do_exit
  sub al, '1'       ; subtract ASCII 1
  jc get_movement   ; if <, wait for another key
  cmp al, 0x09
  jnc get_movement  ; if >=, wait for another key
  cbw               ; expand AL to 16 bits using AH ('cause we can't add AL to BX)
  mov bx, board
  add bx, ax
  mov al, [bx]      ; get square content
  cmp al, 0x3a      ; compare with 0x3a (0x39 is the last ASCII digit)
  jnc get_movement  ; if >=, wait for another key
  call show_crlf
  ret               ; BX now points to square

do_exit:
  int 0x20

show_board:
  mov bx, board
  call show_row
  call show_div
  mov bx, board + 3
  call show_row
  call show_div
  mov bx, board + 6
  jmp show_row

show_row:
  call show_square
  mov al, [line_vertical]
  call display_letter
  call show_square
  mov al, [line_vertical]
  call display_letter
  call show_square

show_crlf:
  mov al, 0x0d ; \r
  call display_letter
  mov al, 0x0a ; \n
  jmp display_letter

show_div:
  mov al, 0xc4
  call display_letter
  mov al, 0xc5
  call display_letter
  mov al, 0xc4
  call display_letter
  mov al, 0xc5
  call display_letter
  mov al, 0xc4
  call display_letter
  jmp show_crlf

show_square:
  mov al, [bx]
  inc bx
  jmp display_letter

find_line:
  ; first horizontal row
  mov al, [board]       ; X.. ... ...
  cmp al, [board + 1]   ; .X. ... ...
  jne _find_line_1
  cmp al, [board + 2]   ; ..X ... ...
  je won
_find_line_1:
  ; leftmost vertical row
  cmp al, [board + 3]   ; ... X.. ...
  jne _find_line_2
  cmp al, [board + 6]   ; ... ... X..
  je won
_find_line_2:
  ; first diagonal
  cmp al, [board + 4]   ; ... .X. ...
  jne _find_line_3
  cmp al, [board + 8]   ; ... ... ..X
  je won
_find_line_3:
  ; second horizontal row
  mov al, [board + 3]   ; ... X.. ...
  cmp al, [board + 4]   ; ... .X. ...
  jne _find_line_4
  cmp al, [board + 5]   ; ... ..X ...
  je won
_find_line_4:
  ; third horizonal row
  mov al, [board + 6]   ; ... ... X..
  cmp al, [board + 7]   ; ... ... .X.
  jne _find_line_5
  cmp al, [board + 8]   ; ... ... ..X
  je won
_find_line_5:
  ; middle vertical row
  mov al, [board + 1]   ; .X. ... ...
  cmp al, [board + 4]   ; ... .X. ...
  jne _find_line_6
  cmp al, [board + 7]   ; ... ... .X.
  je won
_find_line_6:
  ; rightmost vertical row
  mov al, [board + 2]   ; ..X ... ...
  cmp al, [board + 5]   ; ... ..X ...
  jne _find_line_7
  cmp al, [board + 8]   ; ... ... ..X
  je won
_find_line_7:
  ; second diagonal
  cmp al, [board + 4]   ; ... .X. ...
  jne no_line_found
  cmp al, [board + 6]   ; ... ... X..
  je won

; No line was found, so check for a tie
no_line_found:
  mov cx, 8             ; initialise counter to 8 to loop through each square (0-8)
check_tie:
  mov bx, board         ; set BX to first square
  add bx, cx            ; add CX (counter), this will check each square in loop iter
  mov ax, [bx]          ; move square value into AX
  cmp al, 0x3a          ; check if square is >= 0x3a (0x39 is the last ASCII digit)
  jnc _check_tie        ; if it's higher ("X" or "O") repeat loop
  ret                   ; if it was lower (a digit) then return from subroutine (continue game)
_check_tie:
  loop check_tie        ; decrement CX and run check again
  ; if we've looped through each square and they're all set, and we haven't won, we've tied!
  mov al, 't'
  call display_letter
  mov al, 'i'
  call display_letter
  mov al, 'e'
  call display_letter
  call do_exit

; requires that AL contains the winning letter
won:
  call display_letter
  mov al, ' '
  call display_letter
  mov al, 'w'
  call display_letter
  mov al, 'i'
  call display_letter
  mov al, 'n'
  call display_letter
  mov al, 's'
  call display_letter
  call do_exit

; store these at the end so that they're not executed as code
line_horizontal:
  db 0xc4 ; '-'
line_vertical:
  db 0xb3 ; '|'
line_intersection:
  db 0xc5 ; '+'
