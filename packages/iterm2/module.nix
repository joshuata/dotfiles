{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.iterm2;

  jsonFormat = pkgs.formats.json { };

  # Pinned so the scripts are reproducible; bump `rev` and the hashes together.
  shellIntegration =
    let
      rev = "9f4ee84236dca4cd27ad9b208be4effd0bf7e8e7";
      fetch =
        shell: hash:
        pkgs.fetchurl {
          name = "iterm2-shell-integration.${shell}";
          url = "https://raw.githubusercontent.com/gnachman/iTerm2-shell-integration/${rev}/shell_integration/${shell}";
          inherit hash;
        };
    in
    {
      bash = fetch "bash" "sha256-E7aNoQJMCawUZ36bHqUqwRYpuoMdY2LqZqbvFTX06GA=";
      fish = fetch "fish" "sha256-9RGWs1tI4oODSQZE4JHGNvM/IU67UCXk5UpHj01DTaM=";
      zsh = fetch "zsh" "sha256-eF8Y4gPCnI0Gqc03TQgxdIkJ9cYUMXUoeBd2RoH4QKc=";
    };

  # iTerm2's iTermPreferenceSavePrefsMode values.
  saveModes = {
    onQuit = 0;
    never = 1;
    automatically = 2;
  };
in
{
  meta.maintainers = [ ];

  options.programs.iterm2 = {
    enable = lib.mkEnableOption "iTerm2 and its shell integration (only the shell integration outside macOS, e.g. on hosts reached over SSH)";

    package = lib.mkPackageOption pkgs "iterm2" {
      nullable = true;
      extraDescription = "Only installed on macOS. Set to `null` when iTerm2 is installed some other way, e.g. a Homebrew cask.";
    };

    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableFishIntegration = lib.hm.shell.mkFishIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };

    prefsFolder = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      example = lib.literalExpression ''"''${config.xdg.configHome}/iterm2"'';
      description = ''
        Directory iTerm2 loads {file}`com.googlecode.iterm2.plist` from instead
        of its own defaults domain. iTerm2 writes changes back to it, so point it
        at a writable path (e.g. a git checkout), not the Nix store. macOS only.
      '';
    };

    saveChanges = lib.mkOption {
      type = lib.types.enum (lib.attrNames saveModes);
      default = "automatically";
      description = ''
        When iTerm2 saves settings changed in its UI back to
        {option}`programs.iterm2.prefsFolder`. Only used when that is set.
      '';
    };

    dynamicProfiles = lib.mkOption {
      type = lib.types.listOf jsonFormat.type;
      default = [ ];
      example = lib.literalExpression ''
        [
          {
            Name = "Dev";
            Guid = "6f0e3c7a-9b1d-4f8e-a2c5-1d3e5f7a9b0c";
            "Dynamic Profile Parent Name" = "Default";
            "Normal Font" = "JetBrainsMono-Regular 13";
          }
        ]
      '';
      description = ''
        Profiles written to iTerm2's {file}`DynamicProfiles` directory, which
        iTerm2 reloads whenever it changes. Each profile needs a `Name` and a
        unique `Guid`; other keys are profile settings as they appear in
        iTerm2's preferences plist. See
        <https://iterm2.com/documentation-dynamic-profiles.html>. macOS only.
      '';
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.bash.initExtra = lib.mkIf cfg.enableBashIntegration ''
          source ${shellIntegration.bash}
        '';
        programs.fish.interactiveShellInit = lib.mkIf cfg.enableFishIntegration ''
          source ${shellIntegration.fish}
        '';
        programs.zsh.initContent = lib.mkIf cfg.enableZshIntegration ''
          source ${shellIntegration.zsh}
        '';
      }

      # The app itself only exists on macOS; elsewhere (e.g. hosts reached over
      # SSH from iTerm2) only the shell integration above applies.
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

        targets.darwin.defaults."com.googlecode.iterm2" = lib.mkIf (cfg.prefsFolder != null) {
          PrefsCustomFolder = cfg.prefsFolder;
          LoadPrefsFromCustomFolder = true;
          NoSyncNeverRemindPrefsChangesLostForFile = true;
          NoSyncNeverRemindPrefsChangesLostForFile_selection = saveModes.${cfg.saveChanges};
        };

        home.file."Library/Application Support/iTerm2/DynamicProfiles/home-manager.json" =
          lib.mkIf (cfg.dynamicProfiles != [ ])
            {
              source = jsonFormat.generate "iterm2-dynamic-profiles.json" { Profiles = cfg.dynamicProfiles; };
            };
      })
    ]
  );
}
