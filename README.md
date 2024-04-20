# Alexis Lapierre's NixOS configuration

This is my NixOS configuration.
Nothing much to talk about here.

# First configuration

TODO: remember how to configure nix flakes from the command line

Otherwise, just copy your /etc/nixos/hardware-configuration.nix into this folder.

Then run
```bash
mkpassword "Your password" > ~/nix/password
sudo nixos-rebuild --upgrade switch --flake .
```

You can just about delete your /etc/nixos/ folder after that
