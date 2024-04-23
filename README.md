# Alexis Lapierre's NixOS configuration

This is my NixOS configuration.
Nothing much to talk about here.

# First configuration


Otherwise, just copy your /etc/nixos/hardware-configuration.nix into this folder.

Then run
```bash
# TODO: This will not work if you don't activate flakes somewhere.
# I currently activate them in my configuration.nix so this will probably not work out of the box
sudo nixos-rebuild --upgrade switch --flake .#CirnOS
```

You can just about delete your /etc/nixos/ folder after that

On next runs you can run this instead of the nixos-rebuild command:

```bash
nh os switch --update .
```
