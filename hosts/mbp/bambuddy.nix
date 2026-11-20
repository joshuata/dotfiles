# Trust the Bambuddy virtual printer CA in Bambu Studio and OrcaSlicer by
# appending it to each app's bundled printer.cer, per
# https://wiki.bambuddy.cool/features/virtual-printer/#certificate-installation
# App updates replace the bundle, so this re-applies on every activation.
# Runs in postActivation, after the Homebrew casks are installed/upgraded.
let
  cert = ./bambuddy-virtual-printer-ca.crt;
  apps = [
    "/Applications/BambuStudio.app"
    "/Applications/OrcaSlicer.app"
  ];
in
{
  system.activationScripts.postActivation.text = ''
    echo "installing Bambuddy virtual printer CA into slicers..." >&2
    # A base64 line from the cert body identifies it in printer.cer.
    marker=$(sed -n 2p ${cert})
    for app in ${toString apps}; do
      cer="$app/Contents/Resources/cert/printer.cer"
      if [ ! -f "$cer" ]; then
        echo "  $cer not found, skipping" >&2
        continue
      fi
      if grep -qF -- "$marker" "$cer"; then
        continue
      fi
      [ -f "$cer.bak" ] || cp "$cer" "$cer.bak"
      # Make sure the appended cert starts on its own line.
      [ -z "$(tail -c1 "$cer")" ] || echo >> "$cer"
      cat ${cert} >> "$cer"
      echo "  added to $cer" >&2
    done
  '';
}
