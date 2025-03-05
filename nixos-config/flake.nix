
{
  description = "NixOS configuration with Flakes";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ nixpkgs, hyprland, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        # specialArgs = { inherit inputs; };
      };
    };
  };
}


