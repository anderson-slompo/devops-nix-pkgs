pkgs:
{ name, url, sha256 }:
{
  inherit name;
  src = pkgs.fetchurl {
    inherit url sha256;
  };
  nativeBuildInputs = [ pkgs.gzip ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    gzip -dc $src > $out/bin/${name}
    chmod +x $out/bin/${name}
  '';
}
