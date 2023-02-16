{ config, lib, pkgs, host, ... }:

let
    # hardware specific
    touchpad = with host;
        if hostName == "starnix" then ''
            touchpad {
                natural_scroll=true
                middle_button_emulation=true
                tap-to-click=true
            }
        '' else "";
    gestures = with host;
        if hostName == "starnix" then ''
            gestures {
                workspace_swipe=true
            }
        '' else "";
    monitors = with host;
        if hostName == "starnix" then ''
            monitor=${toString mainMonitor},2256x1504@60,0x0,1
        '' else "";
    mediakeys = with host;
        if hostName == "starnix" then ''
            bind=,XF86MonBrightnessUp,exec,brightnessctl set 5%+
            bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
        '' else "";
    execute = with host;
        # autostart
        if hostName == "starnix" then ''
        '' else "";
in
let
    hyprlandConf = with host; ''
        ${execute}
        exec-once=waybar
        ${monitors}

        $mainMod = SUPER

        general {
            sensitivity=1.0 # for mouse cursor
            layout=dwindle

            gaps_in=5
            gaps_out=10
            border_size=2

            col.active_border=0xb3cba6f7
            col.inactive_border=0xb3313244

            apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        }

        decoration {
            rounding=5
            blur=true
            blur_size=10 # minimum 1
            blur_passes=4 # minimum 1, more passes = more resource intensive.
            blur_new_optimizations=true
            # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
            # if you want heavy blur, you need to up the blur_passes.
            # the more passes, the more you can up the blur_size without noticing artifacts.
        }

        animations {
            enabled=1
            animation=windows,1,4,default
            animation=border,1,10,default
            animation=fade,1,10,default
            animation=workspaces,1,4,default
        }

        dwindle {
            pseudotile=0 # enable pseudotiling on dwindle
            force_split=2
        }

        master {
            new_is_master=false
        }

        input {
            kb_layout=us
            kb_variant=
            kb_model=
            kb_options=
            kb_rules=
    
            follow_mouse=1
            float_switch_override_focus=true
            ${touchpad}
        }
        
        ${gestures}

        misc {
            disable_hyprland_logo=true
            disable_splash_rendering=true
            mouse_move_enables_dpms=true
            no_vfr=false
        }

        windowrule=float,blueman
        windowrule=float,file_progress
        windowrule=float,confirm
        windowrule=float,dialog
        windowrule=float,download
        windowrule=float,notification
        windowrule=float,error
        windowrule=float,splash
        windowrule=float,confirmreset
        windowrule=float,title:Open File
        windowrule=float,title:branchdialog

        ${mediakeys}

        bind=SUPER,T,exec,kitty
        bind=SUPER,B,exec,librewolf
        bind=SUPER,E,exec,thunar
        bind=SUPER,Q,killactive,
        bind=SUPERSHIFT,Q,exec,hyprctl kill
        bind=SUPERCTRL,Q,exit,
        bind=SUPER,V,togglefloating,
        bind=SUPER,F,fullscreen,
        bind=SUPER,A,exec,wofi --show drun -I -m -i

        bind=,Print,exec,grim -g "$(slurp)" - | wl-copy -t image/png
        bind=SHIFT,Print,exec,grim $HOME/Pictures/Screenshots/$(date +'%s.png')

        bind=SUPER,H,movefocus,l
        bind=SUPER,J,movefocus,d
        bind=SUPER,K,movefocus,u
        bind=SUPER,L,movefocus,r

        bind=SUPERSHIFT,H,movewindow,l
        bind=SUPERSHIFT,J,movewindow,d
        bind=SUPERSHIFT,K,movewindow,u
        bind=SUPERSHIFT,L,movewindow,r

        bind=SUPERCTRL,L,resizeactive,70 0
        bind=SUPERCTRL,H,resizeactive,-70 0
        bind=SUPERCTRL,K,resizeactive,0 -70
        bind=SUPERCTRL,J,resizeactive,0 70

        bind=SUPER,Space,layoutmsg,swapwithmaster

        bind=SUPER,comma,splitratio,-0.1
        bind=SUPER,period,splitratio,+0.1

        bind=SUPER,I,workspace,-1
        bind=SUPER,O,workspace,+1
        bind=SUPERSHIFT,I,movetoworkspace,-1
        bind=SUPERSHIFT,O,movetoworkspace,+1

        # bind=SUPER,backslash,swapactiveworkspaces,eDP1 

        bind=SUPER,semicolon,exec,playerctl play-pause
        bind=SUPER,bracketleft,exec,playerctl next
        bind=SUPER,bracketright,exec,playerctl previous

        bind=SUPER,1,workspace,1
        bind=SUPER,2,workspace,2
        bind=SUPER,3,workspace,3
        bind=SUPER,4,workspace,4
        bind=SUPER,5,workspace,5
        bind=SUPER,6,workspace,6
        bind=SUPER,7,workspace,7
        bind=SUPER,8,workspace,8
        bind=SUPER,9,workspace,9
        bind=SUPER,0,workspace,10

        bind=SUPERSHIFT,1,movetoworkspace,1
        bind=SUPERSHIFT,2,movetoworkspace,2
        bind=SUPERSHIFT,3,movetoworkspace,3
        bind=SUPERSHIFT,4,movetoworkspace,4
        bind=SUPERSHIFT,5,movetoworkspace,5
        bind=SUPERSHIFT,6,movetoworkspace,6
        bind=SUPERSHIFT,7,movetoworkspace,7
        bind=SUPERSHIFT,8,movetoworkspace,8
        bind=SUPERSHIFT,9,movetoworkspace,9
        bind=SUPERSHIFT,0,movetoworkspace,10

        bind=SUPER,mouse_down,workspace,e-1
        bind=SUPER,mouse_up,workspace,e+1
        bindm=SUPER,mouse:272,movewindow
        bindm=SUPER,mouse:273,resizewindow
    '';
in
{
    xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
}
