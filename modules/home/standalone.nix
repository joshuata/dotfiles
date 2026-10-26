{ pkgs, ... }:

{
  imports = [ ../shared/nix.nix ];

  nix.package = pkgs.nix;
}
