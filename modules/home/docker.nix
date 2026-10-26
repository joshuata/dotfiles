# Docker via OrbStack, with the docker CLI config kept under XDG_CONFIG_HOME.
{ config, lib, ... }:
{
  imports = [ ../../packages/orbstack/home-manager.nix ];

  programs.orbstack = {
    enable = lib.mkDefault true;
    dockerConfigDir = lib.mkDefault "${config.xdg.configHome}/docker";
  };
}
