{ pkgs, ... }:

{
  # 1. Global Options (LazyVim Style settings)
  opts = {
    termguicolors = true;
    background = "dark";
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    wrap = false;
    swapfile = false;
    
    # LazyVim defaults
    signcolumn = "yes";           # Always show the sign column for git/lsp indicators
    clipboard = "unnamedplus";    # Sync with system clipboard natively
    timeoutlen = 300;             # Faster which-key popup display delay
  };

  # 2. Keymaps and Leader Initialization
  globals.mapleader = " "; # This must be set before plugins load for which-key to pick it up!

  keymaps = [
    # Your preserved functional macros
    { mode = "n"; key = "<F2>"; action = ":w<CR>"; options.desc = "Save File"; }
    { mode = "i"; key = "<F2>"; action = "<Esc>:w<CR>"; options.desc = "Save File"; }

    # LazyVim navigation shortcuts
    { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Toggle Explorer (Neo-tree)"; }
    { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; options.desc = "Prev Buffer Tab"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; options.desc = "Next Buffer Tab"; }
  ];

  # 3. Core LazyVim Feature Replications
  plugins = {
    # The Interactive Menu Spacebar Engine
    which-key = {
      enable = true;
      settings = {
        preset = "classic";
        win.border = "single";
      };
    };

    # LazyVim Aesthetic: Startup Dashboard Layout
    alpha = {
      enable = true;
      theme = "dashboard";
    };

    # LazyVim Aesthetic: Top Tab Bar for Open Files
    bufferline = {
      enable = true;
    };

    # LazyVim Aesthetic: Bottom Statusline Styling
    lualine = {
      enable = true;
      settings.options.theme = "dracula";
    };

    # LazyVim Component: Structural File Tree Sidebar
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;
    };

    # LazyVim Component: Fuzzy Finding Layout Panels
    telescope = {
      enable = true;
      keymaps = {
        "<leader><space>" = { action = "find_files"; options.desc = "Find Files (Root)"; };
        "<leader>ff" = { action = "find_files"; options.desc = "Find Files"; };
        "<leader>sg" = { action = "live_grep"; options.desc = "Grep Workspace Text"; };
        "<leader>bb" = { action = "buffers"; options.desc = "Switch Active Buffers"; };
      };
    };

    # Automated Structural Code Helpers
    nvim-autopairs.enable = true; # FIXED: Changed from 'autopairs' to 'nvim-autopairs'
    comment.enable = true;        # Quick comment toggling via 'gcc' and 'gc'

    # Code Scope Visualizations
    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope.enabled = true;
      };
    };

    # Syntax Parser Compiler Configuration
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        ensure_installed = [ "nix" "lua" "haskell" ];
      };
    };
  };
}
