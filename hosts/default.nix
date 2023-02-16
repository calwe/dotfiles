{ lib, inputs, nixpkgs, home-manager, hyprland, user, ... }:

let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
in
{
    framework = lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit inputs user;
            host = {
                hostName = "starnix";
                mainMonitor = "eDP-1";
            };
        };
        modules = [
            hyprland.nixosModules.default
            ./framework
            ./configuration.nix

            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                    inherit user;
                    host = {
                        hostName = "starnix";
                        mainMonitor = "eDP-1";
                    };
                };
                home-manager.users.${user} = {
                    imports = [(import ./home.nix)] ++ [(import ./framework/home.nix)];
                };
            }
        ];
    };
}