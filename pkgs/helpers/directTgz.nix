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
    mkdir -p $out/tmp
    tar xvf $src -C $out/tmp/ --strip-components=1
    touch $out/bin/${name}
    mv -v $(ls $out/tmp/ | head -n 1) $out/bin/${name}
    # chmod +x $out/bin/${name}
  '';
}
