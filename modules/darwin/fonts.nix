{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    cascadia-code
    jetbrains-mono
    meslo-lgs-nf
    monaspace
  ];
}
