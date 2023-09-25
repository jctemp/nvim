vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

if os.getenv("HOME") then
	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
elseif os.getenv("USERPROFILE") then
	vim.opt.undodir = os.getenv("USERPROFILE") .. "/.vim/undodir"
else
	vim.opt.undodir = nil
end

if vim.opt.undodir then
	vim.opt.undofile = true
end

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
