# devops-nix-pkgs

A set of ("devops" related) executables to use in your [nix](https://nixos.org/learn.html) shell in order to get reproducible envs.

Have a look at [./default.nix](./default.nix) to see what's currently available.

## Usage 

create a `shell.nix` file at your project's root and set everything you need for development environment 

```
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
      voodoo.terraform_1_0_1
    ]
  ++ voodoo.bundles.networking-tools pkgs;
}
```

then simply run :

```
nix-shell 
```

check installed packages :
```
terraform version
```
(should output `1.0.1`)
