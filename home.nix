{ config, pkgs, inputs, ... }:
let 
  font-family = "JetBrainsMono Nerd Font";
  font-size   = 15;
in
{
  home.stateVersion = "24.11";
  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          arcticicestudio.nord-visual-studio-code
          bbenoist.nix
          catppuccin.catppuccin-vsc-icons
          golang.go
        ];
        userSettings = {
          "editor.fontLigatures" = true;
          "editor.fontSize" = font-size;
          "editor.fontFamily" = "${font-family}";
          "editor.tabSize" = 2;
          "terminal.integrated.fontFamily" = "${font-family}";
          "workbench.colorTheme" = "Nord";
          "workbench.iconTheme" = "catppuccin.catppuccin-vsc-icons";
          "workbench.startupEditor" = "none";
          "security.workspace.trust.enabled" = false;
          "security.workspace.trust.startupPrompt" = "never";
          "security.workspace.trust.banner" = "never";
          "update.showReleaseNotes" = false;
        };
      };
    };

    alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = {
        font = {
				  normal = {
					  family = "${font-family}";
					  style = "Regular";
				  };
				  bold = {
					  family = "${font-family}";
					  style = "Bold";
				  };
				  italic = {
					  family = "${font-family}";
					  style = "Italic";
				  };
          size = font-size;
        };
        selection.save_to_clipboard = true;
      };
    };

    firefox = {
      enable = true;
      package = pkgs.firefox;
      profiles.jaxon = {
        extensions.packages = with inputs.firefox-addons.packages."aarch64-darwin"; [ublock-origin];
        settings = {
          extensions.pocket.enabled = false;
          # Disable firefox login
          identity.fxaccounts = {
            enabled = false;
            toolbar.enabled = false;
            pairing.enabled = false;
          };
          # Disable tutorial
          browser.uitour.enabled = false;
          browser.newtabpage.activity-stream.showSponsored = false;
          browser.newtabpage.activity-stream.showSponsoredTopSites = false;
        };
      };
    };

    # starship - a customizable prompt for any shell
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        enableZshIntegration = true;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };
}
