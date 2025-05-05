# My Personal Neovim Configuration

## Introduction

This is my personal Neovim configuration, originally based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It serves as my customized development environment.

## Prerequisites

### Install Neovim

This configuration targets the latest stable or nightly build of Neovim. Ensure you have a recent version installed.

* **Stable:** [https://github.com/neovim/neovim/releases/tag/stable](https://github.com/neovim/neovim/releases/tag/stable)
* **Nightly:** [https://github.com/neovim/neovim/releases/tag/nightly](https://github.com/neovim/neovim/releases/tag/nightly)

### Install External Dependencies

Ensure the following external dependencies are installed:

* Basic build tools: `git`, `make`, `unzip`, C Compiler (`gcc`)
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
* Clipboard tool (e.g., `xclip`, `xsel`, `wl-copy`, `win32yank` depending on the platform)
* A [Nerd Font](https://www.nerdfonts.com/) (Optional, for icons)
* Necessary language tooling (compilers, interpreters, servers) for your projects.

## Installation

Clone this repository to your Neovim configuration directory (typically `~/.config/nvim` on Linux/macOS or `%localappdata%\\nvim` on Windows).

```sh
# Example for Linux/macOS
git clone https://github.com/barisgit/neovim-config.git ~/.config/nvim
```

Start Neovim after cloning:

```sh
nvim
```

Plugins will be automatically installed by `lazy.nvim`. Use `:Lazy` to check the status.
