= Alexis Lapierre's NixOS configuration

This is my NixOS configuration.
Nothing much to talk about here.

= First configuration

On a fresh install you need to run these:

```bash
# in your $HOME
git clone git@github.com:Alexis-Lapierre/NixOS.git

# I think this is the correct order? I always forget with ln
ln -svP ~/nix/configuration.nix /etc/nixos/configuration.nix

# Create your password
mkpassword "Your password" > ~/nix/password

# Add unstable as a secondary source:
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable

# Build everything, set it as default for next boot
sudo nixos-rebuild --upgrade 
```
