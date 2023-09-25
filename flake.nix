{
  description = "Wrapper of neovim configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, home-manager, flake-utils }:
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

          # Configuration neovim
          programs.neovim = {
            enable = true;
            withNodeJs = true;
            withPython3 = true;
            withRuby = true;

            plugins = with pkgs.vimPlugins; [
              # auto-detect tabstop and shiftwidth
              vim-sleuth

              # colour theme
              rose-pine

              # telescope
              popup-nvim
              plenary-nvim
              telescope-nvim

              # treesitter
              nvim-treesitter

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

            extraPackages = with pkgs; [
              # Telescope dependencies 
              ripgrep
              fd

              # Language servers
              nil
              rust-analyzer
              nodePackages.yaml-language-server
            ];
          };
        };
      });

}
