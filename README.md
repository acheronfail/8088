# 8088

Following the book [Programming Boot Sector Games](https://nanochess.org/store.html).

## Requirements

* `nasm`: for compiling the `*.asm` files
* `dosbox`: for running the `*.com` files
* `just`: (optional) for running common actions easily

## Reference

Registers:

* `ax`: Accumulator
* `bx`: Common use (address)
* `cx`: Common use (counter)
* `ax`: Common use (32-bit extension of `ax`)
* `si`: Common use (source address)
* `di`: Common use (target address)
* `bp`: Base pointer (used alongside `sp`)
* `sp`: Stack pointer
* Segment Registers
  * `cs`: Segment Register (code execution)
  * `ds`: Segment Register (data)
  * `es`: Segment Register (data)
  * `ss`: Segment Register (stack pointer)
* Flags (separated into bits)
  * `0`:  C - Carry: set when result exceeds capacity of register
  * `1`:  -
  * `2`:  P - Parity: set when number of bits set to 1 in result are even
  * `3`:  -
  * `4`:  A - Auxillary Carry: set when half of the result sets Carry
  * `5`:  -
  * `6`:  Z - Zero: set when result is zero
  * `7`:  S - Sign: takes a copy of the highest bit of the operation
  * `8`:  T - Trap: set when a trap is taken
  * `9`:  I - Interruption: used for low-level hardware
  * `10`: D - Direction: used for string operations (`movs` et al)
  * `11`: O - Overflow: set when the result of an operation exceeds the signed capacity of an 8-bit or 18-bit register
  * `12`: -
  * `13`: -
  * `14`: -
  * `15`: -
* Flags and instructions:
  * `sahf`: store `ah` into bits 7-0 pf flags
  * `lahf`: load bits 7-0 into `ah`
  * `add`, `sub`, `adc`, `sbc`, `and`, `or`, `xor`, `cmp`, `test`, `rol`, `ror`, `rcl`, `rcr`, `shl`, `shr`, `sar`, `neg`, `mul`, `div`, `imul`, `idiv`, `cmps`, `scas`, `daa`, `das`, `aaa`, `aas`, `aam` and `aad`: these affect the `O`, `S`, `Z`, `A`, `P` and `C` flags
  * `inc`, `dec`: these affect `O`, `S`, `Z`, `A` and `P` flags (not `C`!)
  * `clc`: sets `C` to 0
  * `sec`: sets `C` to 1
  * `cmc`: complements the `C` flag
  * `mov`, `lea`, `lds` and `les`: do not affect flags

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
