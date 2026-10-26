# Who commits and signs on this machine. Override per host, e.g.
#   my.identity.email = "me@work.example";
{ lib, ... }:
{
  options.my.identity = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "Josh Asplund";
      description = "Full name used for git commits.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "joshasplund@gmail.com";
      description = "Email address used for git commits.";
    };

    signingKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5oqTYWYNBBFceYJ7OSlYFw2Y+NQjlq15ZyYZf95o3A";
      description = "SSH public key commits are signed with via 1Password, or null to not sign.";
    };
  };
}
