{ homeDirectory
, pkgs
, stateVersion
, system
, username
}:

{
  home = {
    inherit homeDirectory stateVersion username;

    # Packages that should be installed to the user profile.
    packages = [
      pkgs.nil
      pkgs.coursier
      pkgs.httpie
      pkgs.kaf
      #pkgs.jetbrains.idea-community
      pkgs.haskellPackages.haskell-language-server
      pkgs.haskell.compiler.ghc96
      pkgs.zulu17
    ];

    sessionVariables = {
      CC = "gcc";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
      GTK2_RC_FILES = "$HOME/.gtkrc-2.0";
      PATH = "$HOME/.npm/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$GEM_HOME/bin:/home/yushi/.local/share/coursier/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin:$PATH";
      LAST_DIR = "$HOME";
      GEM_HOME = "$(ruby -e 'puts Gem.user_dir')";
      EDITOR = "nvim";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      BROWSER = "brave";
    };

    file.".xmonad_autostart".text = ''
      #!/bin/sh

      # xmobar &
      # sleep 3
      # nm-applet &
      # mictray &

      # trayer --edge top --align right --SetDockType true --SetPartialStrut true \
      #        --expand true --width 5 --transparent true --alpha 0 --tint 0x283339 --height 24 &
      #
    '';
  };

  services = {
    status-notifier-watcher.enable = true;
  };


  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
    viAlias = true;
    vimAlias = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cp = "cp -i";
      df = "df -h";
      free = "free -m";
      more = "less";
      ls = "ls --color=auto";
      grep = "grep --colour=auto";
      egrep = "egrep --colour=auto";
      fgrep = "fgrep --colour=auto";
      zz = "zathura --reparent=$XEMBED";
      mpvv = "mpv --wid=$XEMBED";
    };
    initExtra = ''
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

      [ -f "/home/yushi/.ghcup/env" ] && source "/home/yushi/.ghcup/env" # ghcup-env

      export NVM_DIR=~/.nvm
      [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use


      export NIXPKGS_ALLOW_UNFREE=1

      export PATH=~/.nvm/versions/node/v16.16.0/bin:$PATH
    '';
  };

  programs.xmobar = {
    enable = false;
    extraConfig = ''
      Config { 

         -- appearance
           font =         "xft:JetBrainsMono Nerd Font:size=12:antialias=true:hinting=true"
         , bgColor =      "#283339"
         , fgColor =      "#F9fAF9"
         , position =     Top
         -- , border =       BottomB
         -- , borderColor =  "#646464"

         -- layout
         , sepChar =  "%"   -- delineator between plugin names and straight text
         , alignSep = "}{"  -- separator between left-right alignment
         -- , template = "%StdinReader% }{ %battery% | %multicpu% | %memory% | %date% "
         , template = "%XMonadLog% } %battery% | %default:Master%| %memory% | %date% { "

         -- general behavior
         , lowerOnStart =     False    -- send to bottom of window stack on start
         , hideOnStart =      False   -- start with window unmapped (hidden)
         , allDesktops =      True    -- show on all desktops
         , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
         , pickBroadest =     False   -- choose widest display (multi-monitor)
         , persistent =       True    -- enable/disable hiding (True = disabled)

         -- plugins
         --   Numbers can be automatically colored according to their value. xmobar
         --   decides color based on a three-tier/two-cutoff system, controlled by
         --   command options:
         --     --Low sets the low cutoff
         --     --High sets the high cutoff
         --
         --     --low sets the color below --Low cutoff
         --     --normal sets the color between --Low and --High cutoffs
         --     --High sets the color above --High cutoff
         --
         --   The --template option controls how the plugin is displayed. Text
         --   color can be set by enclosing in <fc></fc> tags. For more details
         --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
         , commands = 
              -- cpu activity monitor
              -- [ Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%|<total2>%|<total3>%|<total4>%|<total5>%|<total6>%|<total7>%|<total8>%|<total9>%|<total10>%|<total11>%|<total12>%|<total13>%|<total14>%|<total15>%"
              --                      , "--Low"      , "50"         -- units: %
              --                      , "--High"     , "85"         -- units: %
              --                      , "--low"      , "darkgreen"
              --                      , "--normal"   , "darkorange"
              --                      , "--high"     , "darkred"
              --                      ] 10

              -- memory usage monitor
              [ Run Memory         [ "--template" ,"Mem: <usedratio>%"
                                   , "--Low"      , "20"        -- units: %
                                   , "--High"     , "90"        -- units: %
                                   , "--low"      , "#1ABC9C"
                                   , "--normal"   , "darkorange"
                                   , "--high"     , "darkred"
                                   ] 10

              -- battery monitor
              , Run Battery        [ "--template" , "Batt: <acstatus>"
                                   , "--Low"      , "10"        -- units: %
                                   , "--High"     , "80"        -- units: %
                                   , "--low"      , "darkred"
                                   , "--normal"   , "darkorange"
                                   , "--high"     , "#1ABC9C"

                                   , "--" -- battery specific options
                                             -- discharging status
                                             , "-o"	, "<left>% (<timeleft>)"
                                             -- AC "on" status
                                             , "-O"	, "<fc=#dAA520>Charging</fc>"
                                             -- charged status
                                             , "-i"	, "<fc=#1ABC9C>Charged</fc>"
                                   ] 50

              -- time and date indicator 
              --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
              , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10
              , Run Volume "default" "Master" [] 10
              , Run XMonadLog ]
         }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/ftp" = "brave-browser.desktop";
        "x-scheme-handler/chrome" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "application/x-extension-htm" = "brave-browser.desktop";
        "application/x-extension-html" = "brave-browser.desktop";
        "application/x-extension-shtml" = "brave-browser.desktop";
        "x-www-browser" = "brave-browser.desktop";
        "application/x-ica" = "citrix-wfica.desktop";
        "application/xhtml+xml" = "brave-browser.desktop";
        "application/x-extension-xhtml" = "brave-browser.desktop";
        "application/x-extension-xht" = "brave-browser.desktop";
      };
    };
  };


  targets.genericLinux.enable = true;

  programs.bash.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  # programs.autorandr = {
  #   enable = true;
  #   profiles = {
  #     amd = {
  #       fingerprint = {
  #         eDP = "00ffffffffffff0009e5400a00000000101f0104b5221578037ce5a4554c9f260f5054000000010101010101010101010101010101016b6e00a0a04084603020360058d71000001a000000fd0c3ca51f1f4e010a202020202020000000fe00424f452043510a202020202020000000fe004e4531363051444d2d4e59310a023b02031d00e3058000e60605016a6a246d1a000002033ca500046a246a240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fe7013790000030114a52f0185ff099f002f001f003f0683000200050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003e90";
  #         HDMI-1-0 = "00ffffffffffff0030aef5655a564232201e0103803c22782e47aea75447982219535eadcf00d1c08180818a9500b300714f01010101023a801871382d40582c450056502100001e2a4480a0703827403020350056502100001a000000fd002f4c325a15000a202020202020000000fc004c454e204432372d3230420a2001e2020327f14b010203040514111213101f230907078301000065030c001000681a00000101304b00011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000188c0ad090204031200c40550056502100001800000000000000000000000000000000000000000000000000000000000000000000f9";
  #       };
  #       config = {
  #         eDP = {
  #           enable = true;
  #           mode = "2560x1600";
  #           rate = "165.00";
  #         };
  #         HDMI-1-0 = {
  #           enable = true;
  #           primary = true;
  #           mode = "1920x1080";
  #           rate = "74.97";
  #           position = "2560x0";
  #         };
  #       };
  #     };
  #     nvidia = {
  #       fingerprint = {
  #         DP-4 = "00ffffffffffff0009e5400a00000000101f0104b5221578037ce5a4554c9f260f5054000000010101010101010101010101010101016b6e00a0a04084603020360058d71000001a000000fd0c3ca51f1f4e010a202020202020000000fe00424f452043510a202020202020000000fe004e4531363051444d2d4e59310a023b02031d00e3058000e60605016a6a246d1a000002033ca500046a246a240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fe7013790000030114a52f0185ff099f002f001f003f0683000200050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003e90";
  #         HDMI-0 = "00ffffffffffff0030aef5655a564232201e0103803c22782e47aea75447982219535eadcf00d1c08180818a9500b300714f01010101023a801871382d40582c450056502100001e2a4480a0703827403020350056502100001a000000fd002f4c325a15000a202020202020000000fc004c454e204432372d3230420a2001e2020327f14b010203040514111213101f230907078301000065030c001000681a00000101304b00011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000188c0ad090204031200c40550056502100001800000000000000000000000000000000000000000000000000000000000000000000f9";
  #       };
  #       config = {
  #         DP-4 = {
  #           enable = true;
  #           mode = "2560x1600";
  #           rate = "165.00";
  #         };
  #         HDMI-0 = {
  #           enable = true;
  #           mode = "1920x1080";
  #           rate = "74.97";
  #         };
  #       };
  #     };
  #   };
  # };

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = self: [ self.taffybar ];
      config = ./xmonad.hs;
    };
    initExtra = ''
      nitrogen --restore &
      dunst &
      picom &
      nm-applet --indicator &
      mictray &
      xbindkeys &
      cbatticon &
      picom --experimental-backends &
      #polybar primary &
      #polybar secondary &
      xlayoutdisplay -w 2
      (sleep 3 && polybar primary)&
      (sleep 3 && polybar secondary)&
    '';
  };
}
