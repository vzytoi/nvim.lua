# Vzytoi's configuration!

## Disclamer

I created this project for personal use, so you might encounter some errors during the installation. I advise you not to use this configuration if you have no knowledge in Lua or in vim/neovim configuration in general. Of course, if you encounter errors, I invite you to report them on this repo so that I can look into them and other potential users don't have to encounter them as well.<br/>
This project aims to be as collaborative as possible. You are free to make any changes you want to the configuration to better fit your needs and tastes. However, if you make changes that you believe could benefit everyone such as bug fixes, optimization or feature additions then I strongly suggest that you share them with everyone!

## Quickstart

First, you need to clone the repository into `appdata/local` for Windows users and `.config` for macOS or Linux users.

> Windows

```
git -C ~/appdata/local clone https://github.com/vzytoi/nvim.lua nvim
```

> Unix, Linux

```
git -C ~/.config clone https://github.com/vzytoi/nvim.lua nvim
```

Then install the necessary plugins using packer.nvim and the treesitter parser.

> Windows, Unix, Linux _(inside nvim)_

```
:PackerSync
:TSInstall all
```

## Performances

First, this test was performed using [startup time](https://github.com/dstein64/vim-startuptime) and represents the average of 100 startups. I removed all items that were > 2% of the total time. Finally, this test was performed using a Unix machine. Be aware that the results obtained on a Windows machine could be 3 or 4 times higher.

```
       startup: 30.2
event                  time percent plot
packer_compiled.lua   13.55   44.83 ██████████████████████████
init.lua               6.20   20.50 ███████████▉
impatient              3.57   11.82 ██████▉
loading packages       2.04    6.75 ███▉
nvim-lsp-installer     1.76    5.82 ███▍
loading rtp plugins    1.63    5.39 ███▏
reading ShaDa          1.07    3.54 ██
vim.lsp                1.01    3.36 ██
expanding arguments    0.99    3.28 █▉
gruvbox.lua            0.87    2.86 █▋
nvim-lsp-installer.u   0.85    2.81 █▋
done waiting for UI    0.77    2.56 █▌
vim.lsp.handlers       0.62    2.07 █▎
```
