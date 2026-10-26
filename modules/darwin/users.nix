# The primary user account and the system shells.
{ config, pkgs, ... }:
let
  user = config.system.primaryUser;
in
{
  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  # security.pam.services.sudo_local.watchIdAuth = true;
}
