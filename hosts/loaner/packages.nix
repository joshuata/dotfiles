{
  pkgs,
  ...
}:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    cachix
    python3
    python3Packages.setuptools
    jq
    mkcert
    ripgrep
    uv
    nss.tools
    rsync
    zstd
  ];

}
