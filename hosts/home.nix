{ config, lib, pkgs, user, ... }:

{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";

        packages = with pkgs; [
            btop
            vscode
            librewolf
            wofi
            discord
            xfce.thunar
            grim
            slurp
            feh
            wl-clipboard
            playerctl
            wofi-wifi-menu
        ];
        pointerCursor = {
            gtk.enable = true;
            name = "Catppuccin-Mocha-Dark-Cursors";
            package = pkgs.catppuccin-cursors.mochaDark;
            size = 16;
        };
        stateVersion = "22.11";
    };

    programs = {
        home-manager.enable = true;
    };

    gtk = {
        enable = true;
        theme = {
            name = "Catppuccin-Mocha-Compact-Mauve-Dark";
            package = pkgs.catppuccin-gtk.override {
                accents = [ "mauve" ];
                size = "compact";
                variant = "mocha";
            };
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
        font = {
            name = "JetBrainsMono Nerd Font Mono";
        };
    };
}
