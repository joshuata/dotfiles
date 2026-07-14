{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:
{
  imports = [
    ./envvars.nix
    ./packages.nix
    ../../modules/common.nix
    ../../modules/devtools.nix
    ../../modules/mise.nix
    ../../modules/vim
    ../../modules/git
    # ../../modules/iterm2.nix
    # ../../modules/macos.nix
    ../../modules/nixdev.nix
    ../../modules/onepass.nix
    ../../modules/jetbrains.nix
    ../../modules/shell
    ../../modules/postgresql.nix
    # ../../modules/ghostty.nix
  ];

}
