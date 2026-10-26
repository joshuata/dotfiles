{
  pkgs,
  ...
}:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    cmake
    cachix
    ddrescue
    jdk
    python3
    python3Packages.setuptools
    delta
    kubernetes-helm
    jq
    mkcert
    mosh
    ripgrep
    step-cli
    esptool
    ansi2html
    uv
    nss.tools
    rsync
    zstd
  ];

}
