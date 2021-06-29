{ pkgs, system }: version:
let
  name = "conftest";
  sha = {
    x86_64-linux = {
      "0.21.0" = "0ihxlyi18pb9v1cl11gkw9d61axgm7ar9kvnzqfi3sfgfw6qkiqs";
    };
  };
  deriv = pkgs.stdenv.mkDerivation {
    inherit name;
    src = pkgs.fetchurl {
      url = "https://github.com/open-policy-agent/conftest/releases/download/v${version}/conftest_${version}_Linux_x86_64.tar.gz";
      sha256 = sha.${system}.${version};
    };
    depsBuildBuild = [ pkgs.gzip ];
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar xf $src 
      mv ./$name $out/bin
    '';
  };
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
