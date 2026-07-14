{ pkgs, ... }:

{
  imports = [
    ./orbstack
  ];

  home.packages = with pkgs; [
    awscli2
    ripgrep
    bat
    nil
    nixfmt
    niv
    nixd
    git-credential-manager
    tsx
    gettext
  ];

  programs = {
    mise = {
      enable = true;
      globalConfig = {
        settings = {
          experimental = true;
          legacy_version_file_disable_tools = [ "terraform" ];
        };
        tools.fnox = "latest";
        tools.hk = "latest";
        plugins.fnox-env = "https://github.com/jdx/mise-env-fnox";
      };
    };
    orbstack = {
      enable = true;
      package = pkgs.orbstack_loc;
    };
    direnv =
      let
        _1password_plugin = builtins.fetchGit {
          url = "https://github.com/tmatilai/direnv-1password.git";
          rev = "45914c0afbfbc4252ef4f90ed68248ee2246deab";
          ref = "v1.0.1";
        };
      in
      {
        enable = true;
        nix-direnv.enable = true;
        mise.enable = true;
        stdlib = ''
          : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
          declare -A direnv_layout_dirs
          direnv_layout_dir() {
              local hash path
              echo "''${direnv_layout_dirs[$PWD]:=$(
                  hash="$(sha1sum - <<< "$PWD" | head -c40)"
                  path="''${PWD//[^a-zA-Z0-9]/-}"
                  echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
              )}"
          }
          source "${_1password_plugin}/1password.sh" }
        '';
      };
  };
}
