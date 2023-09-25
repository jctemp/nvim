require("temple.remap")
require("temple.set")

if os.getenv("NEOVIM_PLUGIN_MGMT") ~= "nix" then
	require("temple.packer")
end


