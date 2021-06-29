{ pkgs, system }: version:
let
  name = "kubectl";
  sha = {
    x86_64-linux = {
      "1.15.10" = "0gx67qggxa6d11w5fdk8pkxhag9hi1k1ks4z2c0dc1qjzkqk7wvx";
      "1.19.4" = "0gx67qggxa6d11w5fdk8pkxhag9hi1k1ks4z2c0dc1qjzkqk7wvx";
    };
  };
  deriv =
    pkgs.stdenv.mkDerivation
      (
        import ./helpers/directBinary.nix pkgs {
          inherit name;
          url = "https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/linux/amd64/kubectl";
          sha256 = sha.${system}.${version};
        }
      );
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
