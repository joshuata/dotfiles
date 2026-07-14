{ config, pkgs, ... }:

{
  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
      extraConfig = builtins.readFile ./baseinit.vim;
      plugins = with pkgs.vimPlugins; [
        YankRing-vim
        catppuccin-vim
        vim-indent-guides
      ];
    };
  };
}
