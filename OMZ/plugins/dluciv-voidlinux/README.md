# Void Linux plugin

Used [Arch Linux](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux) plugin as its basis.

This plugin adds some aliases and functions to work with Void Linux.

To use it, add `dluciv-voidlinux` to the plugins array in your zshrc file:

```zsh
plugins=(... voidlinux)
```

## Features

### XBPS

| Alias        | Command                                | Description                                                      |
|--------------|----------------------------------------|------------------------------------------------------------------|
| upgrade      | `sudo xbps-install --sync --update`    | Sync with repositories, then upgrade packages                 |

## Contributors

- Dmitry V. Luciv - dluciv@dluciv.name
