{
  description = "iTerm2 home-manager module";

  outputs = _: {
    homeManagerModules = rec {
      iterm2 = ./module.nix;
      default = iterm2;
    };
  };
}
