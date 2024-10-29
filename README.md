# Alexis Lapierre's NixOS configuration

This is my NixOS configuration.
Nothing much to talk about here.

# First configuration

Starting with the “default” configuration,
just copy the generated /etc/nixos/hardware-configuration.nix into /device/CirnOS folder.

Then run:
```bash
sudo nixos-rebuild --upgrade boot --flake .#CirnOS
```

After that, you can reboot to try out my CirnOS configuration.

On next runs you can run this instead of the nixos-rebuild command:

```bash
nh os switch --update .
```
