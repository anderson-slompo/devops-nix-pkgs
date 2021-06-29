{ system ? builtins.currentSystem }:
let
  pkgs = import
    (builtins.fetchTarball {
      name = "nixos-21.05";
      url = "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz";
      sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
    })
    { };
  voodoo = import ./default.nix { inherit pkgs system; };
in
pkgs.mkShell {
  buildInputs =
    [
      pkgs.jq
      voodoo.kubectl_1_19_4
      voodoo.polaris_4_0_4
    ]
    ++ voodoo.bundles.networking-tools pkgs;
}
