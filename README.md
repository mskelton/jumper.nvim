# telescope-jumper.nvim

A [Telescope](https://github.com/nvim-telescope/telescope.nvim) extension to
quickly switch your working directory from a list of specified directories
within a workspace.

## Installation

Install with your favorite package manager (e.g. [lazy.nvim](https://github.com/folke/lazy.nvim)):

```lua
{ "mskelton/telescope-jumper.nvim" }
```

Then load the extension:

```lua
require("telescope").load_extension("jumper")
```

## Configuration

```lua
require("telescope").setup {
    extensions = {
        jumper = {
            patterns = {
                "docs",
                "packages/*"
            }
        }
    }
}
```

## Usage

Creating a mapping for the following command in vim:

```vim
:Telescope jumper list
```

or lua:

```lua
require('telescope').extensions.jumper.list()
```
