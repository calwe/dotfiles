{
    description = "My personal NixOS config";

    inputs = {
        nixpkgs.url = "github:calwe/nixpkgs/master";
        home-manager = {
            url = github:/nix-community/home-manager;
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }: let
        user = "calcal";
        location = "$HOME/.nixconf";
    in {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit inputs nixpkgs home-manager hyprland user;
            }
        );
    };
}