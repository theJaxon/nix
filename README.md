# nix

```bash
# https://github.com/LnL7/nix-darwin?tab=readme-ov-file#step-1-creating-flakenix
mkdir -pv ~/nix
cd ~/nix
nix flake init -t nix-darwin/master --extra-experimental-features "nix-command flakes"
nix run nix-darwin  --extra-experimental-features "nix-command flakes" -- switch --flake ~/nix#mac
which darwin-rebuild
darwin-rebuild switch --flake ~/nix#mac
```

### References
1. [Alacritty config file](https://geekbb.xlog.page/Alacritty)
2. [nix on MacOS](https://nixcademy.com/de/posts/nix-on-macos/)
