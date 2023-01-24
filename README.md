# keep-it-secret.nvim
<p align="center">
  <img src="https://media1.giphy.com/media/3oFyCYNrra8qo1Cv8Q/giphy.gif?cid=ecf05e47c6azdr3xbb0zgq45l0ywfygztarh3d5xv3oufvci&rid=giphy.gif&ct=g">
</p>

## What is Keep it Secret?

A plugin designed to keep your secrets safe! Useful for content creators or
anyone who finds themselves often sharing their screens to people who could be
annoying and use their secrets. This plugin shows a warning popup whenever
you enter a file you have specified usually contains your project secrets.

Additionally, this plugin is *persistant*. This means that if you toggle it on, close neovim, and open it again, it will still be on. Same thing for if you toggle it off. I did it this way because often times you close your neovim multiple times while streaming. If you could remember to turn it on every time you open and close neovim while streaming, you probably wouldn't need the plugin in the first place. So, I made it persistent to solve this issue!

![demo](images/demo.png)

## Documention

See `:help keep-it-secret.nvim`

## Installation
Packer: 
```lua
use("roberte777/keep-it-secret.nvim")
```

## Setup
Below is a sample setup with the default configs. If you do not wish to change the default configs, no setup call is required.
Additionally, the wildcards are lua's wildcard syntax, not regex!

The below setup will cause the plugin to show a popup for files that end explicitly in .env and .secret. This means files like .env.local, etc. are not triggered with this config. 

Additioanlly, enabled = false sets the initial enabled value. This value can be toggled, and does not have to be changed from here in order to enable the plugin. View below to see how to set a keybinding to change the enabled value. And remember, the plugin remembers if you enabled it or not, even between sessions!

```lua
require("keep-it-secret").setup({
	wildcards = { ".*(.env)$", ".*(.secret)$" },
	enabled = false
})
```
Sample key-bindings, you do need to set this up because ***I did not provide default keybinds***:
```lua 
vim.api.nvim_set_keymap(
	"n",
	"<leader>ks",
	":lua require('keep-it-secret').toggle()<CR>",
	{ noremap = true, silent = true }
)
```


