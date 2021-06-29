{ pkgs, system }: version:
let
  name = "polaris";
  sha = {
    x86_64-linux = {
      "4.0.4" = "c94ff4a7b3ddffc98aa874bd17f7156cf7c96a8d42e485d26efc4a741ee4d2a9";
    };
    x86_64-darwin = {
      "4.0.4" = "095da8958c2b5ad809c17bbde6548373ff41b40dd63feff45242a39eed62b3aa";
    };
  };
  systemToPath = {
    x86_64-linux = "linux_amd64";
    x86_64-darwin = "darwin_amd64";
  };
  deriv = pkgs.stdenv.mkDerivation {
    src = pkgs.fetchurl {
      url = "https://github.com/FairwindsOps/polaris/releases/download/${version}/polaris_${version}_${systemToPath.${system}}.tar.gz";
      sha256 = sha.${system}.${version};
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar xf $src
      mv ./polaris $out/bin/
    '';
    inherit name;
  };
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
