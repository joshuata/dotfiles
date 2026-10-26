{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.my.identity) signingKey;
in
{
  imports = [ ./identity.nix ];

  home.packages = [ pkgs._1password-cli ];

  # Sign commits with the SSH key held in the 1Password app.
  programs.git.settings = lib.mkIf (signingKey != null) {
    user.signingkey = signingKey;
    gpg.format = "ssh";
    "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    commit.gpgsign = "true";
  };
}
