{ config, pkgs, ... }:

{
  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
      packageConfigurable = pkgs.vim-full.override { guiSupport = "none"; };
      extraConfig = builtins.readFile ./baseinit.vim;
      plugins = with pkgs.vimPlugins; [
        YankRing-vim
        catppuccin-vim
        vim-indent-guides
      ];
    };
  };
}
