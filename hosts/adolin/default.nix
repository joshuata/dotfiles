{ pkgs, ... }:

{
  imports = [
    ../../profiles/dev.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    uv
    ddrescue
    ncdu
    iotop
    progress
    ffmpeg
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];
}
