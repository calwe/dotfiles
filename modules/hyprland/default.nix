{ config, lib, pkgs, host, ... }:
let
    exec = "exec Hyprland";
in
{
    environment = {
        loginShellInit = ''
            if [-z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
                ${exec}
            fi
        '';

        variables = {
            XDG_CURRENT_DESKTOP="Hyprland";
            XDG_SESSION_TYPE="wayland";
            XDG_SESSION_DESKTOP="Hyprland";
            XDG_DATA_HOME="~/.local/share";
        };

        sessionVariables = {
            QT_QPA_PLATFORM = "wayland";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            GDK_BACKEND = "wayland";
            WLR_NO_HARDWARE_CURSORS = "1";
            MOZ_ENABLE_WAYLAND = "1";
        };
    };

    programs = {
        hyprland = {
            enable = true;
        };
    };
}