{ pkgs, ... }:

{
  programs = {
    mise = {
      enable = true;
      globalConfig = {
        settings = {
          experimental = true;
        };
        tools.fnox = "latest";
      };
    };
  };
}
