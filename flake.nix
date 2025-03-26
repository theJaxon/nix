{
  description = "Jaxon nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, firefox-addons }:
  let
    username = "jaxon";
    configuration = { pkgs, ... }: {
    users = {
        users.${username} = {
          name = "${username}";
          home = "/Users/${username}";
        };
      };
    nixpkgs.config.allowUnfree = true;
    environment.shells = [ pkgs.zsh ];
    environment.systemPackages = with pkgs; [
      aerospace
      ansible
      awscli2
      firefox
      git
      go
      google-chrome
      hugo
      jankyborders
      nixfmt-rfc-style
      nodePackages.aws-cdk
      packer
      rar
      terraform
      vim
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
    security.pam.services.sudo_local.touchIdAuth = true;

    system.defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      finder.AppleShowAllExtensions = true;
    };
  };

  homeconfig = {pkgs, ...}: {
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [];
  };

  in
  {
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager 
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.${username} = import ./home.nix;
          };
        }
      ];
    };
  };
}
