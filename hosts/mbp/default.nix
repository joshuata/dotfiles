{
  pkgs,
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
    ../../modules/orbstack
    # ../../modules/iterm2.nix
    # ../../modules/macos.nix
    ../../modules/nixdev.nix
    ../../modules/onepass.nix
    ../../modules/jetbrains.nix
    ../../modules/shell
    ../../modules/postgresql.nix
    ../../modules/obsidian.nix
    # ../../modules/ghostty.nix
  ];

  # Copy .app bundles instead of symlinking so Spotlight/Raycast index them
  targets.darwin = {
    copyApps.enable = true;
    linkApps.enable = false;
  };

  programs = {
    orbstack = {
      enable = true;
      package = pkgs.orbstack_loc;
    };
  };

}
