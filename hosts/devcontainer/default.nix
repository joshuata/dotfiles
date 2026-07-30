{ pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/mise.nix
    ../../modules/vim
    ../../modules/git
    ../../modules/shell
  ];


  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";

  home.sessionVariables = {
    EDITOR = "code";
  };

  programs = {
    vim = {
      defaultEditor = false;
    };
  };
}