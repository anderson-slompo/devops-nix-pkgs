pkgs: system:
{ name, version, sha256 }:
let
  systemToURL = {
    x86_64-linux = "linux_amd64";
    x86_64-darwin = "darwin_amd64";
  };
in
{
  inherit name;
  src = pkgs.fetchurl {
    inherit sha256;
    url = "https://releases.hashicorp.com/${name}/${version}/${name}_${version}_${systemToURL.${system}}.zip";
  };
  nativeBuildInputs = [ pkgs.unzip ];
  sourceRoot = ".";
  dontPatchELF = true;
  noAuditTmpdir = true;
  installPhase = ''
    mkdir -p $out/bin
    mv ${name} $out/bin
  '';
}
