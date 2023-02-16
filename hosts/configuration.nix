{ config, lib, pkgs, inputs, user, ... }:

let
    new-rodin = import ../fonts/new-rodin/default.nix {
        inherit lib;
        fetchzip = pkgs.fetchzip;
    };
in {
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
        shell = pkgs.fish;
    };

    time.timeZone = "Europe/London";
    i18n = {
        defaultLocale = "en_US.UTF-8";
    };

    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    security.rtkit.enable = true;
    security.polkit.enable = true;

    fonts.fontDir.enable = true;
    fonts.fonts = with pkgs; [
        nerdfonts
        new-rodin
    ];

    environment = {
        variables = {
            TERMINAL = "kitty";
            EDITOR = "nvim";
            VISUAL = "nvim";
        };
        systemPackages = with pkgs; [
            killall
            vim
            git
            neovim
            pciutils
            usbutils
            wget
            xdg-utils
        ];
    };

    services = {
        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
            jack.enable = true;
        };
        flatpak.enable = true;
    };

    nix = {
        settings = {
            auto-optimise-store = true;
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 2d";
        };
        package = pkgs.nixVersions.unstable;
        registry.nixpkgs.flake = inputs.nixpkgs;
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs          = true
            keep-derivations      = true
        '';
    };
    nixpkgs.config.allowUnfree = true;

    system = {
        autoUpgrade = {
            enable = true;
            channel = "https://nixos.org/channels/nixos-unstable";
        };
        stateVersion = "22.11";
    };
}