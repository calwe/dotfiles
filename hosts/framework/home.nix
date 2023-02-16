{ pkgs, ... }:

{
    imports =
        [
            ../../modules/hyprland/home.nix
            ../../modules/kitty/home.nix
            ../../modules/starship/home.nix
            ../../modules/fish/home.nix
            ../../modules/waybar/home.nix
        ];

    home = {
        packages = with pkgs; [
            brightnessctl
        ];
    };
}