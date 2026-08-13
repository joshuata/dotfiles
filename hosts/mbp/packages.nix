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
    nodejs
    ddrescue
    jdk
    python3
    delta
    kubernetes-helm
    jq
    mkcert
    mosh
    ripgrep
    step-cli
    esptool
    rustup
    ansi2html
    uv
    nss.tools
    pnpm
    rsync
    cargo-generate
    zstd
  ];

}
