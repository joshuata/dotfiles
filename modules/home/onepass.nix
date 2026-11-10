{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.my.identity) signingKey;
  agentSock = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  imports = [ ./identity.nix ];

  home.packages = [ pkgs._1password-cli ];

  # Use the 1Password SSH agent for ssh itself and for anything that reads
  # SSH_AUTH_SOCK (ssh-add, agent forwarding, container socket mounts).
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".IdentityAgent = "\"${agentSock}\"";
  };
  home.sessionVariables.SSH_AUTH_SOCK = agentSock;

  # Sign commits with the SSH key held in the 1Password app.
  programs.git.settings = lib.mkIf (signingKey != null) {
    user.signingkey = signingKey;
    gpg.format = "ssh";
    "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    commit.gpgsign = "true";
  };
}
