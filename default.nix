{ pkgs, system ? builtins.currentSystem }:
let
  bats = import ./pkgs/bats-core.nix pkgs;
  conftest = import ./pkgs/conftest.nix { inherit pkgs system; };
  helm = import ./pkgs/helm.nix { inherit pkgs system; };
  kind = import ./pkgs/kind.nix { inherit pkgs system; };
  kubectl = import ./pkgs/kubectl.nix { inherit pkgs system; };
  polaris = import ./pkgs/fairwindsPolaris.nix { inherit pkgs system; };
  terraform = import ./pkgs/terraform.nix { inherit pkgs system; };
  operator-sdk = import ./pkgs/operator-sdk-go.nix { inherit pkgs system; };
in
{
  ## AVAILABLE PACKAGES ##

  # bats
  bats_1_3_0 = bats "1.3.0";

  # conftest (OPA)
  conftest_0_21_0 = conftest "0.21.0";

  # helm
  helm_3_3_4 = helm "3.3.4";
  helm_3_4_2 = helm "3.4.2";

  # kind
  kind_0_9_0 = kind "0.9.0";
  kind_0_11_1 = kind "0.11.1";

  # kubectl
  kubectl_1_15_10 = kubectl "1.15.10";
  kubectl_1_19_4 = kubectl "1.19.4";

  # k8s operator sdk
  operator-sdk_1_3_0 = operator-sdk "1.3.0";

  # polaris
  polaris_4_0_4 = polaris "4.0.4";

  # terraform
  terraform_0_11_14 = terraform "0.11.14";
  terraform_0_12_29 = terraform "0.12.29";
  terraform_0_13_2 = terraform "0.13.2";
  terraform_0_14_6 = terraform "0.14.6";
  terraform_0_15_4 = terraform "0.15.4";
  terraform_1_0_1 = terraform "1.0.1";

  bundles = {
    networking-tools = import ./bundles/networking-tools.nix;
  };
}
