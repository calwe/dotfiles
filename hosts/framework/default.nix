{ config, pkgs, user, ... }:

{
    imports =
        [(import ./hardware-configuration.nix)] ++
        [(import ../../modules/hyprland/default.nix)] ++
        [(import ../../modules/waybar/default.nix)];
    
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
            };
            grub = {
                enable = true;
                device = "nodev";
                version = 2;
                efiSupport = true;
                enableCryptodisk = true;
                useOSProber = true;
                configurationLimit = 2;
            };
        };
    };
}