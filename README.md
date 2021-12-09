# 8088

Following the book [Programming Boot Sector Games](https://nanochess.org/store.html).

## Requirements

* `nasm`: for compiling the `*.asm` files
* `dosbox`: for running the `*.com` files
* `just`: (optional) for running common actions easily

## Reference

Assembly operators mapped to C/Java/JavaScript:

* `xor`: `^`
* `or`: `|`
* `and`: `&`
* `not`: `~`
* `neg`: `-` (unary)
* `shl`: `<<`
* `shr`/`sar`: `>>`
* `div`: `/`
* `idiv`: `/` (signed)
* `mul`: `*`
* `imul`: `*` (signed)
* `add`: `+`
* `sub`: `-` (binary)

Other operators that don't map:

* `nop`: nothing
* `rcl`: rotate left through carry
* `rcr`: rotate right through carry
* `rol`: rotate left (circular)
* `ror`: rotate right (circular)
* `ret`: return from subroutine
* `call`: call subroutine
* `cmp`: perform comparison
* `in`: read port
* `push`: push value to stack
* `pop`: pop value from stack

Jump/conditional instructions:

* Pretty useful with `cmp`/`sub`
  * `je   d8`: Jump if equal
  * `jz   d8`: Jump if zero
  * `jne  d8`: Jump if not equal
  * `jnz  d8`: Jump if not zero
  * `jc   d8`: Jump if Carry set (unsigned less than)
  * `jb   d8`: Jump if unsigned less than.
  * `jnc  d8`: Jump if Carry not set (unsigned greater equal)
  * `jae  d8`: Jump if unsigned greater than or equal.
  * `jbe  d8`: Jump if unsigned less than or equal
  * `ja   d8`: Jump if unsigned greater than
  * `jl   d8`: Jump if signed less than
  * `jg   d8`: Jump if signed greater than
  * `jle  d8`: Jump if signed less than or equal
  * `jge  d8`: Jump if signed greater than or equal
* More useful with `and`/`or`/`xor`/`test`
  * `js   d8`: Jump if result is negative
  * `jns  d8`: Jump if result is non-negative
  * `jpe  d8`: Jump if parity is even
  * `jpo  d8`: Jump if parity is odd
* More useful with arithmetic operations
  * `jo   d8`: Jump if overflow
  * `jno  d8`: Jump if non-overflow
* General use
  * `jcxz d8`: Jump if CX is zero
  * `loop d8`: Decrement CX and jump if non-zero
