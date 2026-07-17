{
  description = "Najib's Declarative self-contained LazyVim-like Neovim package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, ... }:
    let
      system = "x86_64-linux"; # Your standard NixOS architecture
      pkgs = import nixpkgs { inherit system; };

      # This bundles all packages, plugins, options, and themes together
      my-neovim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = import ./nixvim/default.nix;
      };
    in
    {
      # Export the finished application package directly
      packages.${system}.default = my-neovim;

      # Local testing sandbox terminal shell hook
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ my-neovim ];

        /*
        shellHook = ''
          # Isolates Neovim state/cache paths completely
          export NVIM_APPNAME="nvim-sandbox"

          echo "========================================================"
          echo "  Welcome to your isolated Neovim Sandbox!              "
          echo "  - Run 'nvim' to test your configuration.              "
          echo "  - All runtime cache/state maps to:                     "
          echo "    ~/.local/share/nvim-sandbox                         "
          echo "========================================================"
        '';
        */
        shellHook = ''
          # Isolates Neovim state/cache paths completely
          export NVIM_APPNAME="nvim-sandbox"

          echo "========================================================"
          echo "  Welcome to your isolated Neovim Sandbox!              "
          echo ""
          echo "  All runtime cache/state maps to:                     "
          echo "    ~/.local/share/nvim-sandbox                         "
          echo ""
          echo "  To test your latest changes"
          echo "    Run nvim with 'nix run . --'"
          echo "  OR"
          echo "    nix build"
          echo "    ./result/bin/nvim"
          echo "  OR"
          echo "    nix build"
          echo "    nvim"
          echo "========================================================"
        '';

      };
    };
}
