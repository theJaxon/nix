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
      nixpkgs.config.allowUnfree = true;
      environment.shells = [ pkgs.zsh ];
      environment.systemPackages = with pkgs; [
        aerospace
        ansible
        alacritty
        awscli2
        fluxcd
        go
        hugo
        helix
        jankyborders
        kubernetes-helm
        logseq
        nixfmt-rfc-style
        nodePackages.aws-cdk
        nushell
        packer
        qemu
        rar
        terraform
        vim
        vscode
        yq-go
      ];

      fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];
      programs.zsh.enable = true;
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
