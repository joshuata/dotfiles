{
  config,
  lib,
  pkgs,
  ...
}:
let
  awsConfig = "${config.home.homeDirectory}/.aws/config";
in
{
  home.packages = [ pkgs.awscli2 ];

  # Seed ~/.aws/config only when absent: `aws login` writes login_session
  # into it, so it must stay a regular writable file, not a store symlink.
  home.activation.seedAwsConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e ${lib.escapeShellArg awsConfig} ]; then
      run mkdir -p ${lib.escapeShellArg (dirOf awsConfig)}
      run install -m 644 ${./config} ${lib.escapeShellArg awsConfig}
    fi
  '';
}
