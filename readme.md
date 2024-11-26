# Raylib for V

> Up-to-date, auto-generated Raylib (and Raymath) bindings for V

Current Raylib Target: v5.5

## Installation

`mkdir -p ~/.vmodules/emmathemartian/ && git clone https://github.com/emmathemartian/raylib-for-v ~/.vmodules/emmathemartian/raylib-for-v`

## Usage

Barring a small handful of differences, it is the exact same as Raylib's C API.

Differences:
- Functions and parameters are renamed from `PascalCase` to `camel_case`
- Colours are V constants, not as macros
- Any function that uses or returns a C-string instead uses a V-string

## Why?

There are already a handful of V Raylib bindings, but they almost all are out-of-date or
are poorly maintained. For that reason, I decided to do it myself.

I also wanted to have documentation comments in the bindings, which is not provided by
many Raylib bindings in general as far as I know.

## License

Raylib for V is dual-licensed under MIT and the Unlicense. Use whichever works best for
you! :D
