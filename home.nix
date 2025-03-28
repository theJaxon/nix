{ config, pkgs, inputs, ... }:
let 
  font-family = "JetBrainsMono Nerd Font";
  font-size   = 15;
  tab-size    = 2;
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
          "editor.tabSize" = tab-size;
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
        colors = {
          draw_bold_text_with_bright_colors = false;
          primary.background = "#15141b";
          primary.foreground = "#edecee";
          cursor.cursor = "#00D1FF";
        };
        keyboard.bindings = [
          {
            action = "SpawnNewInstance";
            key = "N";
            mods = "Command";
          }
          {
            chars = "\u001BB";
            key = "Left";
            mods = "Command";
          }
        ];
        cursor.style.shape = "Beam";
        selection.save_to_clipboard = true;
        terminal.shell.program = "/run/current-system/sw/bin/zellij";
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

    zellij = {
      enable = true;
      settings = {
        show_startup_tips = false;
      };
    };

    # starship - a customizable prompt for any shell
    starship = {
      enable = true;
      settings = {
        # # Insert a blank line between shell prompts
        add_newline = true;
        enableZshIntegration = true;
        aws.disabled = true;
        gcloud.disabled = true;
        golang.symbol = "go ";
        # Disable the line break between the first and second prompt lines
        line_break.disabled = true;
      };
    };
  };
}
