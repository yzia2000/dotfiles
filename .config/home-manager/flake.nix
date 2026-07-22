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
      # ----------------------------------------------------------------------
      hosts = {
        archyoga = {
          # Lenovo YOGA 920, i7-8550U. eDP-1 advertises 1920x1080 only.
          monitors = [ "eDP-1, preferred, 0x0, 1.25" ];
        };

        legion = {
          # 2560x1600 165Hz panel; 1.6 is a whole-pixel scale (-> 1600x1000).
          monitors = [ "eDP-1, 2560x1600@165, 0x0, 1.6" ];
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

      mkHome = hostName: host: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          home
          (hostModule hostName host)
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
