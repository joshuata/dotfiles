# iTerm2 (installed by Homebrew cask) loading its preferences from
# com.googlecode.iterm2.plist in this directory of the live checkout, so UI
# changes are saved back into the repo and tracked by git.
{ config, lib, ... }:
{
  imports = [
    ../../../packages/iterm2/module.nix
  ];

  programs.iterm2 = {
    enable = lib.mkDefault true;
    package = lib.mkDefault null;
    prefsFolder = lib.mkDefault "${config.xdg.configHome}/nix-darwin/modules/home/iterm2";
  };
}
