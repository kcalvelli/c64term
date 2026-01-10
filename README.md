# C64 Term

Authentic Commodore 64 terminal experience for modern Linux systems.

## Features

- **Authentic C64 Colors**: Classic blue background (#3e31a2) and light blue text (#7c70da)
- **Full PETSCII Palette**: Complete 16-color Commodore 64 color scheme
- **C64 Boot Screen**: Shows actual system RAM with "READY." prompt
- **Blinking Cursor**: Classic block cursor █
- **Fish Shell**: Pre-configured with C64 color theme
- **Ghostty Terminal**: Modern terminal with C64 configuration

## Installation

### As a Flake Package

```bash
nix run github:kcalvelli/c64term
```

### In NixOS Configuration

```nix
{
  inputs = {
    c64term.url = "github:kcalvelli/c64term";
  };

  # In your system configuration
  environment.systemPackages = [
    inputs.c64term.packages.${pkgs.stdenv.hostPlatform.system}.c64term
  ];
}
```

### With Home Manager

```nix
{
  home.packages = [
    inputs.c64term.packages.${pkgs.stdenv.hostPlatform.system}.c64term
  ];
}
```

## Requirements

- **Ghostty** terminal emulator
- **Fish** shell

## Usage

Launch C64 Shell:

```bash
c64term
```

The shell will display an authentic C64 boot screen with your actual system RAM information, followed by the classic "READY." prompt.

To enter the BASIC interpreter, type:
```bash
basic
```

To exit BASIC, use `SYSTEM` or press `Ctrl+C`.

## Configuration

The C64 shell runs in an isolated configuration directory to avoid affecting your main Ghostty setup. Configuration is stored in `$XDG_RUNTIME_DIR/c64-xdg-config/`.

## Development

```bash
# Clone the repository
git clone https://github.com/kcalvelli/c64term
cd c64term

# Build the package
nix build

# Run directly
nix run
```

## License

MIT

## Credits

- Created for [axiOS](https://github.com/kcalvelli/axios) - A modular NixOS distribution
- [C64 Pro Mono Font](https://style64.org/c64-truetype) by Style64
