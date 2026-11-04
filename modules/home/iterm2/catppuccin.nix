# One iTerm2 dynamic profile per Catppuccin flavor, built from the palette with
# the same color mapping as github:catppuccin/iterm's build.ts. Profiles
# inherit everything else (font, hotkey, ...) from the default profile.
{ inputs, lib, ... }:
let
  palette = lib.importJSON "${inputs.catppuccin-palette}/palette.json";
  flavors = lib.removeAttrs palette [ "version" ];

  toItermColor =
    {
      r,
      g,
      b,
    }:
    {
      "Red Component" = r / 255.0;
      "Green Component" = g / 255.0;
      "Blue Component" = b / 255.0;
      "Alpha Component" = 1.0;
      "Color Space" = "sRGB";
    };

  profile =
    id: flavor:
    let
      colors = lib.mapAttrs (_: color: toItermColor color.rgb) flavor.colors;
      ansiColors = lib.listToAttrs (
        lib.concatMap (
          color:
          map (v: lib.nameValuePair "Ansi ${toString v.code} Color" (toItermColor v.rgb)) [
            color.normal
            color.bright
          ]
        ) (lib.attrValues flavor.ansiColors)
      );
    in
    ansiColors
    // {
      Name = "Catppuccin ${flavor.name}";
      Guid = "catppuccin-${id}";
      "Background Color" = colors.base;
      "Foreground Color" = colors.text;
      "Link Color" = colors.sky;
      "Bold Color" = colors.text;
      "Cursor Color" = colors.rosewater;
      "Cursor Text Color" = colors.base;
      "Cursor Guide Color" = colors.text // {
        "Alpha Component" = 0.07;
      };
      "Selection Color" = colors.surface2;
      "Selected Text Color" = colors.text;
    };
in
{
  programs.iterm2.dynamicProfiles = lib.mapAttrsToList profile flavors;
}
