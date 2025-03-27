# nix
![Nix](https://img.shields.io/badge/nix-text?style=for-the-badge&logo=nixos&label=built%20with)

Using nix to make package management reliable and reproducible.

```bash
# https://github.com/LnL7/nix-darwin?tab=readme-ov-file#step-1-creating-flakenix
mkdir -pv ~/nix
cd ~/nix
nix flake init -t nix-darwin/master --extra-experimental-features "nix-command flakes"
nix run nix-darwin  --extra-experimental-features "nix-command flakes" -- switch --flake ~/nix#mac
which darwin-rebuild
darwin-rebuild switch --flake ~/nix#mac
```

---

### References
1. [Common Nix Patterns - devenv docs](https://devenv.sh/common-patterns/#escape-nix-curly-braces-inside-shell-scripts)
2. [nix on MacOS](https://nixcademy.com/de/posts/nix-on-macos/)
3. [Alacritty config file](https://geekbb.xlog.page/Alacritty)