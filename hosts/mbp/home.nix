{ config, ... }:
{
  imports = [
    ./packages.nix
    ../../profiles/dev.nix
    ../../modules/home/xdg-env.nix
    ../../modules/home/node.nix
    ../../modules/home/rust.nix
    ../../modules/home/postgresql.nix
    ../../packages/orbstack/home-manager.nix
    # ../../modules/home/iterm2.nix
    ../../modules/home/onepass.nix
    ../../modules/home/jetbrains.nix
    ../../modules/home/obsidian.nix
  ];

  programs.orbstack = {
    enable = true;
    dockerConfigDir = "${config.xdg.configHome}/docker";
  };
}
