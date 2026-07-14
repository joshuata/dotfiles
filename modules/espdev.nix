{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    ninja
    ccache
    dfu-util
  ];
}
