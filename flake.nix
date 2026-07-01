{
  description = "Isolated Nixvim Sandbox Directory Setup";

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

      # Build the sandbox package using your separate default.nix file
      nv-sandbox = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = import ./nixvim/default.nix;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ nv-sandbox ];

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
      };
    };
}
