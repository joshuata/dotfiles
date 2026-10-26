# Point tools that default to dotfiles in $HOME at the XDG base directories.
{ config, ... }:
{
  home.sessionVariables = {
    LANG = "en_US.UTF-8";

    ANSIBLE_HOME = "${config.xdg.configHome}/ansible";
    GOPATH = "${config.xdg.dataHome}/go";
  };

}
