require("temple.remap")
require("temple.set")

-- The flake sets the NEOVIM_PLUGIN_MGMT environment variable as we don't have
-- to install plugins because Nix is managing it.
if os.getenv("NEOVIM_PLUGIN_MGMT") ~= "nix" then
	require("temple.packer")
end
