{
  description = "skip's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    hyprlauncher.url = "github:hyprwm/hyprlauncher";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        zohshia = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./common/configuration.nix
            ./hosts/zohshia/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.skip = {
                imports = [
                  ./common
                  ./common/wm/hyprland
                  ./hosts/zohshia
                ];
              };
            }
          ];
        };
      };
    };
}
