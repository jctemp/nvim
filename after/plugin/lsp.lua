---
-- LSP Config
---
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local lsp_format = require("lsp-format")
lsp_format.setup {}

-- Merge the defaults lspconfig provides with the capabilities nvim-cmp adds
lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- useful remaps if lsp attaches
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "gd", '<cmd>lua vim.lsp.buf.definition()<cr>')
		bufmap("n", "K", '<cmd>lua vim.lsp.buf.hover()<cr>')
		bufmap("n", "<leader>vws", '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
		bufmap("n", "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>')
		bufmap("n", "[d", '<cmd>lua vim.diagnostic.goto_next()<cr>')
		bufmap("n", "]d", '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		bufmap("n", "<leader>vca", '<cmd>lua vim.lsp.buf.code_action()<cr>')
		bufmap("n", "<leader>vrr", '<cmd>lua vim.lsp.buf.references()<cr>')
		bufmap("n", "<leader>vrn", '<cmd>lua vim.lsp.buf.rename()<cr>')
		bufmap("i", "<C-h>", '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	end
})


---
-- LSP Severs
-- (lspconfig.<name>.setup{})
---


lspconfig.bashls.setup { on_attach = lsp_format.on_attach }
lspconfig.clangd.setup { on_attach = lsp_format.on_attach }
lspconfig.cssls.setup { on_attach = lsp_format.on_attach }
lspconfig.grammarly.setup { on_attach = lsp_format.on_attach }
lspconfig.html.setup { on_attach = lsp_format.on_attach }
lspconfig.java_language_server.setup { on_attach = lsp_format.on_attach }
lspconfig.jsonls.setup { on_attach = lsp_format.on_attach }
lspconfig.lua_ls.setup { on_attach = lsp_format.on_attach }
lspconfig.marksman.setup { on_attach = lsp_format.on_attach }
lspconfig.metals.setup { on_attach = lsp_format.on_attach }
lspconfig.nil_ls.setup { on_attach = lsp_format.on_attach }
lspconfig.rust_analyzer.setup { on_attach = lsp_format.on_attach }
lspconfig.texlab.setup { on_attach = lsp_format.on_attach }
lspconfig.tsserver.setup { on_attach = lsp_format.on_attach }
lspconfig.yamlls.setup { on_attach = lsp_format.on_attach }
lspconfig.java_language_server.setup { on_attach = lsp_format.on_attach }

---
-- CMP and Snippets
--
---

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- loads vscode style snippets (e.g. friendly-snipplets)
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')         -- autocompletes
local luasnip = require('luasnip') -- expands autocompletion

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'buffer',   keyword_length = 3 },
		{ name = 'luasnip',  keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	formatting = {
		fields = { 'menu', 'abbr', 'kind' },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'lsp',
				luasnip = 'snip',
				buffer = 'buf',
				path = 'path',
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
		['<C-n>'] = cmp.mapping.select_next_item(select_opts),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- confirm with enter
		['<C-Space>'] = cmp.mapping.complete(),       -- show completion suggestion
		['<C-e>'] = cmp.mapping.abort(),              -- close completion window
	},
})
