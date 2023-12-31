{
  description = "Wrapper of neovim configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        plugin = repo: owner: rev: sha256: pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "${pkgs.lib.strings.sanitizeDerivationName repo}";
          version = rev;
          src = pkgs.fetchFromGitHub {
            inherit repo owner rev sha256;
          };
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        homeManagerModule = {
          # Generate files in home folder
          home.file.".config/nvim" = {
            enable = true;
            recursive = true;
            source = "${self}";
          };

          home.sessionVariables = {
            NEOVIM_PLUGIN_MGMT = "nix";
          };


          home.packages = with pkgs; [
              # Telescope dependencies 
              ripgrep
              fd

              # Language servers
              ccls # c, c++
              java-language-server # java
              lua-language-server # lua
              marksman # markdown
              metals # scala
              nil # nix
              nodePackages.bash-language-server # bash
              nodePackages.grammarly-languageserver # english 
              nodePackages.typescript-language-server # typescript, javascript
              nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
              nodePackages.yaml-language-server # yaml
              python311Packages.python-lsp-server # python
              rust-analyzer # rust
              texlab # tex
              typst-lsp # typst
              java-language-server # java
            ];

          # Configuration neovim
          programs.neovim = {
            enable = true;
            withNodeJs = false;
            withPython3 = false;
            withRuby = false;

            plugins = with pkgs.vimPlugins; [
              # auto-detect tabstop and shiftwidth
              vim-sleuth

              # colour theme
              rose-pine

              # status line
              lualine-nvim

              # telescope
              popup-nvim
              plenary-nvim
              telescope-nvim

              # treesitter
              nvim-treesitter.withAllGrammars

              # lsp
              nvim-lspconfig
              lsp-format-nvim

              # autocompletion
              nvim-cmp
              cmp-buffer
              cmp-path
              cmp_luasnip
              cmp-nvim-lsp
              luasnip
              friendly-snippets
            ];
          };
        };
      });

}
