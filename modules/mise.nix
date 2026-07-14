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
        tools.hk = "latest";
      };
    };
    git = {
      settings = {
        hook."hk-pre-commit" = {
          command = ''test "''${HK:-1}" = "0" || mise x -- hk run pre-commit --from-hook "$@"'';
          event = "pre-commit";
        };
        hook."hk-pre-push" = {
          command = ''test "''${HK:-1}" = "0" || mise x -- hk run pre-push --from-hook "$@"'';
          event = "pre-push";
        };
        hook."hk-commit-msg" = {
          command = ''test "''${HK:-1}" = "0" || mise x -- hk run commit-msg --from-hook "$@"'';
          event = "commit-msg";
        };
      };
    };
  };
}
