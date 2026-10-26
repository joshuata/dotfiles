{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    nixfmt
    niv
    nixd
  ];
}
