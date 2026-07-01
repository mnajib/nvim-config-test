{ pkgs, ... }:

{

  # Global Options
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
  };

  # Enable Managed Plugins
  plugins = {
    # The interactive spacebar menu you requested
    which-key = {
      enable = true;
      settings = {
        preset = "classic";
        win.border = "single";
      };
    };

    # Syntax parser compiler
    treesitter = {
      enable = true;
      settings.ensure_installed = [ "nix" "lua" "haskell" ];
    };

    # Scoping lines
    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope.enabled = true;
      };
    };
  };

  # Your Functional Keymaps
  keymaps = [
    { mode = "n"; key = "<F2>"; action = ":w<CR>"; options.desc = "Save File"; }
    { mode = "i"; key = "<F2>"; action = "<Esc>:w<CR>"; options.desc = "Save File"; }
  ];

}
