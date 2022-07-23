# Vzytoi's configuration!

## Disclamer

I created this project for personal use, so you might encounter some errors during the installation. I advise you not to use this configuration if you have no knowledge in Lua or in vim/neovim configuration in general. Of course, if you encounter errors, I invite you to report them on this repo so that I can look into them and other potential users don't have to encounter them as well.<br/>
This project aims to be as collaborative as possible. You are free to make any changes you want to the configuration to better fit your needs and tastes. However, if you make changes that you believe could benefit everyone such as bug fixes, optimization or feature additions then I strongly suggest that you share them with everyone!x

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

## Configuration arborecence

```
nvim
│   README.md
│   init.lua    
│
└─── lua 
│   │   abbr.lua
│   │   autocmds.lua
│   │   colors.lua
│   │   fn.lua
│   │   mappings.lua
│   │   opts.lua
│   │   plugins.lua
│   │
│   └─── plugins
│       │   cmp.lua
│       │   lsp.lua
│       │   resize.lua
│       │   telescope.lua
│       │   tree.lua
│       │   formatter.lua
│       │   term.lua
│       │   treesitter.lua
│       │
│       └─── lualine
│       │   │   init.lua
│       │   │  
│       │   └─── themes
│       │       │   spacecamp.lua
│       │ 
│       └─── runcode
│           │   init.lua
│           │   lang.lua
└─── snippets
    │   javascript.snippets
    │   lua.snippets   
    │   php.snippets
    │   python.snippets
    │   rust.snippets
```

## Plugins

- [fedepujol/move.nvim](https://github.com/fedepujol/move.nvim)<br/>
- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)<br/>
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)<br/>
- [tpope/vim-surround](https://github.com/tpope/vim-surround)<br/>
- [romainl/vim-cool](https://github.com/romainl/vim-cool)<br/>
- [wellle/targets.vim](https://github.com/wellle/targets.vim)<br/>
- [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)<br/>
- [farmergreg/vim-lastplace](https://github.com/farmergreg/vim-lastplace)<br/>
- [michaeljsmith/vim-indent-object](https://github.com/michaeljsmith/vim-indent-object)<br/>
- [morhetz/gruvbox](https://github.com/morhetz/gruvbox)<br/>
- [lewis6991/impatient.nvim](https://github.com/lewis6991/impatient.nvim)<br/>
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)<br/>
- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)<br/>
- [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)<br/>
- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)<br/>
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)<br/>
  - [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)<br/>
  - [RRethy/nvim-treesitter-textsubjects](https://github.com/RRethy/nvim-treesitter-textsubjects)<br/>
  - [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)<br/>
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)<br/>
  - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)<br/>
  - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)<br/>
  - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)<br/>
  - [tzachar/cmp-tabnine](https://github.com/tzachar/cmp-tabnine)<br/>
  - [onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim)<br/>
- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)<br/>
- [szw/vim-maximizer](https://github.com/szw/vim-maximizer)<br/>
- [nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre)<br/>
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)<br/>
- [mhartington/formatter.nvim](https://github.com/mhartington/formatter.nvim)<br/>
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)<br/>
  - [williamboman/nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)<br/>
  - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)<br/>
- [kkoomen/vim-doge](https://github.com/kkoomen/vim-doge)<br/>
- [folke/zen-mode.nvim](https://github.com/folke/zen-mode.nvim)<br/>
- [rktjmp/paperplanes.nvim](https://github.com/rktjmp/paperplanes.nvim)<br/>
- [xiyaowong/accelerated-jk.nvim](https://github.com/xiyaowong/accelerated-jk.nvim)<br/>
- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)<br/>
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)<br/>
- [folke/persistence.nvim](https://github.com/folke/persistence.nvim)<br/>
- [dstein64/vim-startuptime](https://github.com/dstein64/vim-startuptime)<br/>
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)<br/>
- [jaredgorski/spacecamp](https://github.com/jaredgorski/spacecamp)<br/>
- [justinmk/vim-sneak](https://github.com/justinmk/vim-sneak)<br/>
- [LionC/nest.nvim](https://github.com/LionC/nest.nvim)<br/>
- [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)<br/>
- [cappyzawa/trim.nvim](https://github.com/cappyzawa/trim.nvim)<br/>
- [hoob3rt/lualine.nvim](https://github.com/hoob3rt/lualine.nvim)<br/>
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)<br/>
- [alvan/vim-closetag](https://github.com/alvan/vim-closetag)<br/>

