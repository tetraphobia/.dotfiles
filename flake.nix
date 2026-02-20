{
  description = "skip's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  {
    nixosConfigurations = {
      test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common/configuration.nix
          ./hosts/test/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.skip = {
              imports = [
                ./common/home.nix
                ./common/wm/hyprland.nix
                ./hosts/test/home.nix
              ];
            };
          }
        ];
      };
    };
  };
}
