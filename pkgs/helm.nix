{ pkgs, system }: version:
let
  name = "helm";
  sha = {
    x86_64-linux = {
      "3.3.4" = "0b78l51rwxi6niw8kq9x3r4pkn4h2n3hdi45xgg4cr63hck66r5n";
      "3.4.2" = "cacde7768420dd41111a4630e047c231afa01f67e49cc0c6429563e024da4b98";
    };
  };
  deriv = pkgs.stdenv.mkDerivation {
    inherit name;
    src = pkgs.fetchurl {
      url = "https://get.helm.sh/helm-v${version}-linux-amd64.tar.gz";
      sha256 = sha.${system}.${version};
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/tmp
      tar -xf $src -C $out/tmp/
      mv $out/tmp/linux-amd64 $out/bin
      chmod +x $out/bin/helm
    '';
  };
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
