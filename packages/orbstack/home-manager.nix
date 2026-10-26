# module.nix with its package defaulting to this flake's build, so no
# overlay or nixpkgs version is required.
{ lib, pkgs, ... }:
{
  imports = [ ./module.nix ];

  programs.orbstack.package = lib.mkDefault (pkgs.callPackage ./package.nix { });
}
