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
