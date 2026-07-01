# Isolated Neovim Sandbox (Nixvim Engine)

This repository contains a standalone, 100% declarative Neovim configuration built with Nixvim. It uses a hybrid testing architecture that combines a Nix Dev Shell with Neovim's native NVIM_APPNAME namespace targeting to allow development and testing without altering your production editor's runtime environments, cache, or histories.

## Sandboxed Development Workflow

### 1. Initialize Git Tracker

Nix flakes strictly require files to be tracked by Git to evaluate them. If you add new configuration blocks or files under `nixvim/`, ensure they are staged:

```Bash
git init && git add .
```

### 2. Enter the Isolated Development EnvironmentDrop into the local environment shell. This pulls down your locked dependencies and overrides runtime path targets:

```Bash
nix develop
```

   Tip: If you have `direnv` and `nix-direnv` configured on your system, entering this directory via your terminal will execute this layer automatically!

### 3. Launch the Sandbox Editor

Execute the standard editor command inside the shell:

```Bash
nvim
```

Because the dev shell exports `NVIM_APPNAME="nvim-sandbox"`, this instance runs completely isolated from your normal system setup:

- Configuration: Built purely out of `./nixvim/default.nix`.
- State / History / Undo files: Written exclusively to `~/.local/share/nvim-sandbox`.
- Cache parameters: Written exclusively to `~/.cache/nvim-sandbox`.

## Production Integration Pipeline

Once your feature experiments, new LSPs, or keybindings are stable and tested within the sandbox, integrate them cleanly into your primary NixOS/Home Manager flake using a Flake-to-Flake architecture.

### Step 1: Commit Upstream Changes

Commit your stable configuration modifications inside this repository:Bashgit checkout main

```term
git add .
git commit -m "feat: added new stable language servers and structural custom keymaps"
```

### Step 2: Update Production Flake References

Ensure your primary production NixOS repository flake input targets this local repository path:

```Nix
inputs = {
  my-nvim.url = "git+file:///home/najib/src/nvim-config-test";
};
```

### Step 3: Run System Rebuild

Navigate to your primary system configuration directory, update the locked input reference hash, and switch your active generation profile:

```Bash
nix flake update my-nvim
sudo nixos-rebuild switch
```

When running `nvim` outside of the development directory, Neovim drops back to its standard vanilla behavior—reading your newly integrated configuration while utilizing your production state paths (`~/.local/share/nvim`) flawlessly.
