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

    # Custom invisible character symbols
    list = true;
    listchars = "trail:█,tab:>-,extends:»,precedes:«,nbsp:•";
  };

  # 2. Keymaps and Leader Initialization
  globals.mapleader = " "; # This must be set before plugins load for which-key to pick it up!

  keymaps = [
    # My Legacy Function Keys / functional macros
    { mode = "i"; key = "<F1>"; action = "<Esc>:q<CR>"; options.desc = "Quit"; }
    { mode = "n"; key = "<F1>"; action = ":q<CR>"; options.desc = "Quit"; }
    { mode = "i"; key = "<F2>"; action = "<Esc>:w<CR>"; options.desc = "Save File"; }
    { mode = "n"; key = "<F2>"; action = ":w<CR>"; options.desc = "Save File"; }
    { mode = "i"; key = "<F3>"; action = "<Esc>:wq<CR>"; options.desc = "Save and Quit"; }
    { mode = "n"; key = "<F3>"; action = ":wq<CR>"; options.desc = "Save and Quit"; }

    # LazyVim dynamic navigation shortcuts
    { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Toggle Explorer (Neo-tree)"; }
    { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; options.desc = "Prev Buffer Tab"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; options.desc = "Next Buffer Tab"; }

    # THE THEME TOGGLER: Press Spacebar + u + c to view all installed colorschemes live
    { mode = "n"; key = "<leader>uc"; action = "<cmd>Telescope colorscheme<cr>"; options.desc = "Select Colorscheme Palette"; }
  ];

  # Dynamic Themes Available to Choose From
  colorschemes = {
    # Replicates the Tokyonight style visible in your screenshot
    tokyonight = {
      enable = true;
      settings.style = "moon"; # Try 'storm', 'night', or 'day'
    };
    gruvbox.enable = true;
  };

  # Your Declarative SkyWizard Custom Theme Definitions
  # This executes automatically if you don't override it via Telescope!
  #colorscheme = "default";
  colorscheme = "tokyonight"; # i like this
  #colorscheme = "skywizard"; # my custom colorscheme

  /*
  highlight = {
  #highlightOverride = {
    # UI Element Identifiers from skywizard.lua
    Normal = { fg = "#ffffff"; bg = "#000000"; };
    Visual = { bg = "#285577"; };
    CursorLine = { bg = "#1a1a1a"; };
    LineNr = { fg = "#696969"; bg = "#333333"; };
    CursorLineNr = { fg = "#ffcc66"; bg = "#1a1a1a"; bold = true; };
    Search = { bg = "#3a3a3a"; fg = "#ffffff"; };
    IncSearch = { reverse = true; };

    # Syntax Token Groups from skywizard.lua
    Comment = { fg = "#767676"; italic = true; };
    String = { fg = "#ffa0a0"; };
    Constant = { fg = "#ffa0a0"; };
    Character = { fg = "#ffa0a0"; };
    Number = { fg = "#ffa0a0"; };
    Boolean = { fg = "#ffa0a0"; };
    Float = { fg = "#ffa0a0"; };
    Function = { fg = "#40ffff"; };
    Identifier = { fg = "#40ffff"; };
    Statement = { fg = "#ffff60"; bold = true; };
    Keyword = { fg = "#ffff60"; bold = true; };
    Type = { fg = "#60ff60"; bold = true; };
    PreProc = { fg = "#ff80ff"; };
    Special = { fg = "Orange"; };
    Delimiter = { fg = "Orange"; };
  };
  */

  # Injecting 'skywizard' Into the Runtime Path
  extraFiles = {
    "colors/skywizard.lua".text = ''
      -- 1. Initialize and clear previous states
      vim.cmd("hi clear")
      if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
      end

      -- 2. Load Gruvbox base highlights into the background
      vim.cmd("colorscheme gruvbox")

      -- 3. Overwrite with your custom SkyWizard definitions[cite: 5]
      local function hi(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
      end

      -- UI Elements[cite: 5]
      hi("Normal", { fg = "#ffffff", bg = "#000000" })
      hi("Visual", { bg = "#285577" })
      hi("CursorLine", { bg = "#1a1a1a" })
      hi("LineNr", { fg = "#696969", bg = "#333333" })
      hi("CursorLineNr", { fg = "#ffcc66", bg = "#1a1a1a", bold = true })
      hi("Search", { bg = "#3a3a3a", fg = "#ffffff" })
      hi("IncSearch", { reverse = true })

      -- Syntax Token Overrides[cite: 5]
      hi("Comment", { fg = "#767676", italic = true })
      hi("String", { fg = "#ffa0a0" })
      hi("Constant", { fg = "#ffa0a0" })
      hi("Character", { fg = "#ffa0a0" })
      hi("Number", { fg = "#ffa0a0" })
      hi("Boolean", { fg = "#ffa0a0" })
      hi("Float", { fg = "#ffa0a0" })
      hi("Function", { fg = "#40ffff" })
      hi("Identifier", { fg = "#40ffff" })
      hi("Statement", { fg = "#ffff60", bold = true })
      hi("Keyword", { fg = "#ffff60", bold = true })
      hi("Type", { fg = "#60ff60", bold = true })
      hi("PreProc", { fg = "#ff80ff" })
      hi("Special", { fg = "Orange" })
      hi("Delimiter", { fg = "Orange" })

      -- Explicitly set your global color registration flag[cite: 5]
      vim.g.colors_name = "skywizard"
    '';
  };

  # Core LazyVim Feature Replications
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
      #settings.options.theme = "dracula";
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

  }; # End plugins = { ... };

}
