local ok, telescope = pcall(require, "telescope")
if not ok then
	error("Install nvim-telescope/telescope.nvim to use mskelton/jumper.nvim.")
end

local list = require("jumper.list")
local opts = {}

return telescope.register_extension({
	setup = function(jumper_opts, _)
		opts = jumper_opts
	end,
	exports = {
		list = function(_)
			list(_, opts)
		end,
	},
})
