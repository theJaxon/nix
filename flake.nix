{
  description = "Jaxon nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;
      environment.shells = [ pkgs.nushell ];
      environment.shellAliases = {
        ls = "eza";
        la = "eza --all";
        ll = "eza -ll --icons";
    };
      environment.systemPackages =
        [
          pkgs.aerospace
          pkgs.alacritty
          pkgs.eza
          pkgs.fluxcd
          pkgs.hugo
          pkgs.helix
          pkgs.jankyborders
          pkgs.kubernetes-helm
          pkgs.nushell
          pkgs.rar
          pkgs.vim
          pkgs.wireshark
          pkgs.yq-go
          pkgs.zed-editor
        ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      programs.zsh.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.enableSudoTouchIdAuth = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
      };
    };
  in
  {
    # $ darwin-rebuild build --flake .#mac
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
