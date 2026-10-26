{ config, ... }:
{
  homebrew.importBrewfile = ./brewfile.rb;

  home-manager.users.${config.system.primaryUser} =
    { config, ... }:
    {
      imports = [
        ./envvars.nix
        ./packages.nix
        ../../profiles/dev.nix
        ../../packages/orbstack/home-manager.nix
        # ../../modules/home/iterm2.nix
        ../../modules/home/onepass.nix
        ../../modules/home/jetbrains.nix
        ../../modules/home/postgresql.nix
        ../../modules/home/obsidian.nix
      ];

      programs.orbstack = {
        enable = true;
        dockerConfigDir = "${config.xdg.configHome}/docker";
      };
    };
}
