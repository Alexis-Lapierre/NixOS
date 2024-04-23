{stdenv, makeDesktopItem, hydrus, ...}:
stdenv.mkDerivation (finalAttributes: {
  name = "hydrus-desktop";
  buildInputs = [ hydrus ];
  desktopItem = makeDesktopItem {
    name = "Hydrus Network";
    exec = "hydrus-client";
    desktopName = "Hydrus Network";
  };
  src = ./.;

  installPhase = ''
      # desktop item
    mkdir -p "$out/share"
    ln -s "${finalAttributes.desktopItem}/share/applications" "$out/share/applications"
    '';
})
