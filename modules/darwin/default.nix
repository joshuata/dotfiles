{
  imports = [
    ./nix.nix
    ./home-manager.nix
    ./users.nix
    ./fonts.nix
    ./homebrew.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
