# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, ... }: {
  _1password-cli-beta = pkgs.callPackage ./_1password-cli-beta { };
  orbstack = pkgs.callPackage ./orbstack { };
}