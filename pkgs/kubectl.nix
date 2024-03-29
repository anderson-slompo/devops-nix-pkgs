{ pkgs, system }: version:
let
  name = "kubectl";
  sha = {
    x86_64-linux = {
      "1.15.10" = "0gx67qggxa6d11w5fdk8pkxhag9hi1k1ks4z2c0dc1qjzkqk7wvx";
      "1.19.4" = "0gx67qggxa6d11w5fdk8pkxhag9hi1k1ks4z2c0dc1qjzkqk7wvx";
    };
    x86_64-darwin = {
      "1.15.10" = "00ldfcrr7gdvhwq1rih55ll00bizh5r85c1mys30zmxqwcvsj55c";
      "1.19.4" = "1jfhjj8y49al1x8ipwjc8264ics6lq15r9m0qjyrl11i6c0hr5hp";
    };
  };
  systemToPath = {
    x86_64-linux = "linux";
    x86_64-darwin = "darwin";
  };
  deriv =
    pkgs.stdenv.mkDerivation
      (
        import ./helpers/directBinary.nix pkgs {
          inherit name;
          url = "https://storage.googleapis.com/kubernetes-release/release/v${version}/bin/${systemToPath.${system}}/amd64/kubectl";
          sha256 = sha.${system}.${version};
        }
      );
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
