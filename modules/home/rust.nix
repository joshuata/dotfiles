{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
    cargo-generate
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };
}
