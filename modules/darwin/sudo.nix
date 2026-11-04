# Touch ID (and a paired Apple Watch) for sudo, written to /etc/pam.d/sudo_local
# so it survives macOS updates. Falls back to the password over SSH etc.
{
  security.pam.services.sudo_local = {
    # Reattach to the user's session so Touch ID works inside tmux.
    reattach = true;
    touchIdAuth = true;
  };
}
