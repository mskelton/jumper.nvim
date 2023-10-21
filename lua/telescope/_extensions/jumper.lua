local ok, telescope = pcall(require, "telescope")
if not ok then
	error(
		"Install nvim-telescope/telescope.nvim to use mskelton/telescope-jumper.nvim."
	)
end

local list = require("telescope._extensions.jumper.list")

--- @type jumper.Opts
local opts = {}

return telescope.register_extension({
	--- @param jumper_opts jumper.Opts
	setup = function(jumper_opts, _)
		opts = jumper_opts
	end,
	exports = {
		list = function(_)
			list(_, opts)
		end,
	},
})
