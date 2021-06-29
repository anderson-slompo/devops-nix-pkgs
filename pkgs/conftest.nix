{ pkgs, system }: version:
let
  name = "conftest";
  sha = {
    x86_64-linux = {
      "0.21.0" = "0ihxlyi18pb9v1cl11gkw9d61axgm7ar9kvnzqfi3sfgfw6qkiqs";
    };
    x86_64-darwin = {
      "0.21.0" = "14pbd2aajv2f74225db3c7scg9r0hsjn798pnlk2kcvb013lh6fh";
    };
  };
  systemToPath = {
    x86_64-linux = "Linux_x86_64";
    x86_64-darwin = "Darwin_x86_64";
  };
  deriv = pkgs.stdenv.mkDerivation {
    inherit name;
    src = pkgs.fetchurl {
      url = "https://github.com/open-policy-agent/conftest/releases/download/v${version}/conftest_${version}_${systemToPath.${system}}.tar.gz";
      sha256 = sha.${system}.${version};
    };
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
