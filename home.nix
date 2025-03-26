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
          "terminal.integrated.fontFamily" = "${font-family}";
          "workbench.colorTheme" = "Nord";
          "workbench.iconTheme" = "catppuccin.catppuccin-vsc-icons";
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
      };
    };
  };
}