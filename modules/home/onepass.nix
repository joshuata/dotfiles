{ pkgs, ... }:
{
  home.packages = [ pkgs._1password-cli ];

  # Sign commits with the SSH key held in the 1Password app.
  programs = {
    git = {
      settings = {
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5oqTYWYNBBFceYJ7OSlYFw2Y+NQjlq15ZyYZf95o3A";
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        commit.gpgsign = "true";
      };
    };
  };
}
