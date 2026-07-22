{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      # Values you should modify
      username = "yushi"; # $USER
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      stateVersion = "25.05";     # See https://nixos.org/manual/nixpkgs/stable for most recent

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "${homeDirPrefix}/${username}";

      # ----------------------------------------------------------------------
      # Per-host settings. Anything NOT listed here is shared by every machine.
      #
      # The attribute name must match the machine's `hostnamectl --static`
      # output, so that a bare `home-manager switch --flake .` resolves to the
      # right configuration automatically.
      #
      # `monitors` is rendered into ~/.config/hypr/monitors.conf, which
      # hyprland.conf sources. Prefer `preferred` over a hardcoded mode: asking
      # for a mode the panel does not advertise in its EDID makes the modeset
      # fail, and aquamarine segfaults on the first frame afterwards.
      #
      # `deadSpeaker` (null on most hosts) silences one channel of the built-in
      # speaker pair at the ALSA mixer. See deadSpeakerModule below.
      # ----------------------------------------------------------------------
      hosts = {
        archyoga = {
          # Lenovo YOGA 920, i7-8550U. eDP-1 advertises 1920x1080 only.
          monitors = [ "eDP-1, preferred, 0x0, 1.25" ];

          deadSpeaker = {
            card = "PCH";                          # `amixer -c` / /proc/asound/cards
            device = "alsa_card.pci-0000_00_1f.3"; # wireplumber device.name
            channel = "frontleft";                 # amixer channel token
          };
        };

        legion = {
          # 2560x1600 165Hz panel; 1.6 is a whole-pixel scale (-> 1600x1000).
          monitors = [ "eDP-1, 2560x1600@165, 0x0, 1.6" ];

          deadSpeaker = null;
        };
      };

      # The shared configuration, identical on every host.
      home = import ./home.nix {
        inherit homeDirectory pkgs stateVersion system username;
      };

      # The per-host overlay: a module holding only what differs per machine.
      hostModule = hostName: host: {
        xdg.configFile."hypr/monitors.conf".text = ''
          # GENERATED for host "${hostName}" -- do not edit.
          # Source of truth: hosts.${hostName}.monitors in flake.nix
          ${builtins.concatStringsSep "\n" (map (m: "monitor = ${m}") host.monitors)}
        '';
      };

      # ----------------------------------------------------------------------
      # A physically dead speaker, silenced at the ALSA mixer -- the only layer
      # below everything that can turn it back on.
      #
      # Per-channel *stream* volume (`pactl set-sink-volume @DEFAULT_SINK@ 0%
      # 75%`) does not survive: `wpctl set-volume`, which the XF86AudioRaise/
      # Lower binds in hypr/hyprland.conf use, writes one volume to every
      # channel, so the first volume keypress un-mutes the dead side. Nor does
      # a wireplumber `audio.position` override ([ NA, FR ]): pipewire's
      # channelmix falls back to a 1:1 map when the target position is unknown
      # and keeps feeding the channel (measured off the sink monitor).
      #
      # The card's `Speaker` control has an independent per-channel mute, so
      # mute the dead channel there. `api.alsa.soft-mixer` is the other half:
      # it moves pipewire's volume handling into software so ACP stops driving
      # the hardware mixer and cannot undo the mute.
      # ----------------------------------------------------------------------
      deadSpeakerModule = hostName: host: { pkgs, ... }:
        nixpkgs.lib.optionalAttrs (host.deadSpeaker != null) (
          let d = host.deadSpeaker; in {
            xdg.configFile."wireplumber/wireplumber.conf.d/51-soft-mixer.conf".text = ''
              # GENERATED for host "${hostName}" -- do not edit.
              # Source of truth: hosts.${hostName}.deadSpeaker in flake.nix
              #
              # Keep pipewire off the hardware mixer, so the muted
              # ${d.channel} channel stays muted.
              monitor.alsa.rules = [
                {
                  matches = [
                    { device.name = "${d.device}" }
                  ]
                  actions = {
                    update-props = {
                      api.alsa.soft-mixer = true
                    }
                  }
                }
              ]
            '';

            systemd.user.services.mute-dead-speaker = {
              Unit.Description =
                "Mute the dead ${d.channel} speaker channel on card ${d.card}";
              Service = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart =
                  "${pkgs.alsa-utils}/bin/amixer -c ${d.card} sset Speaker ${d.channel} 0% mute";
              };
              Install.WantedBy = [ "default.target" ];
            };
          }
        );

      mkHome = hostName: host: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          home
          (hostModule hostName host)
          (deadSpeakerModule hostName host)
        ];
      };
    in
    {
      # One configuration per host, named "<user>@<hostname>".
      homeConfigurations = nixpkgs.lib.mapAttrs'
        (hostName: host:
          nixpkgs.lib.nameValuePair "${username}@${hostName}" (mkHome hostName host))
        hosts;
    };
}
