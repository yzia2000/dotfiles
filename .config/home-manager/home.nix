{ homeDirectory
, pkgs
, stateVersion
, system
, username
}:

{ config, lib, ... }:

{
  home = {
    inherit homeDirectory stateVersion username;

    # Packages that should be installed to the user profile.
    packages = [
      pkgs.nil
      # tree-sitter CLI (>=0.26.1) — nvim-treesitter `main` uses it (+ a C
      # compiler) to install/generate parsers via :TSUpdate / :TSInstall.
      pkgs.tree-sitter
      pkgs.coursier
      pkgs.httpie
      pkgs.kaf
      #pkgs.jetbrains.idea-community
      pkgs.haskellPackages.haskell-language-server
      pkgs.haskell.compiler.ghc96
      pkgs.zulu17

      # neovim binary with the python3 provider (needed by UltiSnips). Config is
      # fully managed by xdg.configFile."nvim" below, so we do NOT use
      # programs.neovim (which would generate a conflicting init.lua into the
      # symlinked nvim dir).
      (pkgs.neovim.override {
        withPython3 = true;
        extraPython3Packages = ps: with ps; [ pynvim ];
      })

      # Fonts — "Minimal" rice (Flexoki)
      pkgs.nerd-fonts.commit-mono  # neutral monospace: ghostty/nvim/waybar
      pkgs.inter                   # Minimal theme's UI sans
    ];

    sessionVariables = {
      CC = "gcc";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
      GTK2_RC_FILES = "$HOME/.gtkrc-2.0";
      PATH = "$HOME/.npm/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$GEM_HOME/bin:/home/yushi/.local/share/coursier/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin:$HOME/core/llama.cpp/build/bin:$PATH";
      LAST_DIR = "$HOME";
      GEM_HOME = "$(ruby -e 'puts Gem.user_dir')";
      EDITOR = "nvim";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      BROWSER = "brave";
      VCPKG_ROOT = "~/.local/share/vcpkg";
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

  # neovim is installed as a package (see home.packages); its config lives in
  # the repo and is symlinked via xdg.configFile."nvim". Treesitter grammars
  # are managed at runtime by lazy.nvim (nvim-treesitter + :TSUpdate).

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Flexoki "Minimal" — monochrome, blue only on matches for readability.
    colors = {
      "fg" = "#CECDC3";
      "bg" = "-1";          # inherit terminal background
      "hl" = "#4385BE";     # matched chars — the one accent
      "fg+" = "#E6E4D9";
      "bg+" = "#282726";    # selected line (base-900)
      "hl+" = "#4385BE";
      "info" = "#6F6E69";
      "border" = "#343331";
      "prompt" = "#878580";
      "pointer" = "#878580";
      "marker" = "#879A39";
      "spinner" = "#6F6E69";
      "header" = "#6F6E69";
    };
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

      export PATH="$HOME/.opencode/bin:$HOME/.npm-global/bin:$PATH"

      export NIXPKGS_ALLOW_UNFREE=1
      [[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
      export OLLAMA_CONTEXT_LENGTH=64000
      # Secrets live in an untracked file (see secrets.env.example), never in git.
      [ -f "$HOME/.config/home-manager/secrets.env" ] && source "$HOME/.config/home-manager/secrets.env"

      # kitty: full-bleed for TUIs — drop window padding to 0 while nvim/yazi
      # run, restore the configured padding on exit. No-op outside kitty.
      _kitty_fullbleed() {
        if [ -z "$KITTY_WINDOW_ID" ]; then command "$@"; return $?; fi
        kitty @ set-spacing padding=0 >/dev/null 2>&1
        command "$@"
        local ret=$?
        kitty @ set-spacing padding=default >/dev/null 2>&1
        return $ret
      }
      nvim() { _kitty_fullbleed nvim "$@"; }
      yazi() { _kitty_fullbleed yazi "$@"; }

      # ls / file listings — Flexoki file-type colors (truecolor).
      # Dirs: bright blue #4385BE bold (was dull default #205EA6). Symlink cyan,
      # executable green, broken link red; archives orange, media purple.
      export LS_COLORS="di=1;38;2;67;133;190:ln=38;2;58;169;159:or=1;38;2;209;77;65:mi=1;38;2;209;77;65:ex=1;38;2;135;154;57:pi=38;2;135;133;128:so=38;2;139;126;200:bd=38;2;208;162;21:cd=38;2;208;162;21:su=38;2;218;112;44:sg=38;2;218;112;44:tw=1;38;2;67;133;190:ow=1;38;2;67;133;190:st=1;38;2;67;133;190:*.tar=38;2;218;112;44:*.tgz=38;2;218;112;44:*.gz=38;2;218;112;44:*.zip=38;2;218;112;44:*.xz=38;2;218;112;44:*.zst=38;2;218;112;44:*.bz2=38;2;218;112;44:*.7z=38;2;218;112;44:*.rar=38;2;218;112;44:*.jpg=38;2;139;126;200:*.jpeg=38;2;139;126;200:*.png=38;2;139;126;200:*.gif=38;2;139;126;200:*.bmp=38;2;139;126;200:*.svg=38;2;139;126;200:*.webp=38;2;139;126;200:*.mp4=38;2;139;126;200:*.mkv=38;2;139;126;200:*.webm=38;2;139;126;200:*.mov=38;2;139;126;200:*.mp3=38;2;135;133;128:*.flac=38;2;135;133;128:*.wav=38;2;135;133;128:*.pdf=38;2;208;162;21:*.md=38;2;208;162;21:*.txt=38;2;206;205;195"

      # zsh-syntax-highlighting — Flexoki "Minimal" palette.
      # Valid commands green, errors red, quotes yellow; everything else calm.
      typeset -gA ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[default]='fg=#CECDC3'
      ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#D14D41'
      ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#8B7EC8'
      ZSH_HIGHLIGHT_STYLES[command]='fg=#879A39'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=#879A39'
      ZSH_HIGHLIGHT_STYLES[function]='fg=#879A39'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=#879A39'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=#879A39,italic'
      ZSH_HIGHLIGHT_STYLES[path]='fg=#CECDC3,underline'
      ZSH_HIGHLIGHT_STYLES[globbing]='fg=#DA702C'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#D0A215'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#D0A215'
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#3AA99F'
      ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#3AA99F'
      ZSH_HIGHLIGHT_STYLES[comment]='fg=#6F6E69,italic'
      ZSH_HIGHLIGHT_STYLES[redirection]='fg=#878580'
      ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#878580'
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#878580'
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#878580'
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

  # Register home-manager-installed fonts with fontconfig (needed on genericLinux)
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg = {
    enable = true;

    # App configs managed by home-manager (source of truth: ./config/*).
    # Static configs are copied into the store; nvim uses an out-of-store
    # (mutable) symlink so lazy.nvim can still write lazy-lock.json.
    configFile = {
      "kitty/kitty.conf".source = ./config/kitty/kitty.conf;
      "hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
      "hypr/hyprlock.conf".source = ./config/hypr/hyprlock.conf;
      "hypr/hypridle.conf".source = ./config/hypr/hypridle.conf;
      "waybar/config.jsonc".source = ./config/waybar/config.jsonc;
      "waybar/style.css".source = ./config/waybar/style.css;
      "starship.toml".source = ./config/starship.toml;
      "nvim".source = config.lib.file.mkOutOfStoreSymlink
        "${homeDirectory}/.config/home-manager/config/nvim";
    };

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
        "application/x-ica" = "wfica.desktop";
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
