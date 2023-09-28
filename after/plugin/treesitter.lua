require 'nvim-treesitter.configs'.setup {
  -- The configuration is managed by the Nix package manager. Therefore, we
  -- do not need to set `ensure_installed` or `auto_install` as the parsers
  -- are already installed through Nix.
  --
  -- ensure_installed = { "lua", "vim", "vimdoc", "query", "c" },
  -- sync_install = false,
  -- auto_install = true,
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
