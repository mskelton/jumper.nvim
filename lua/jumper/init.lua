local util = require("jumper.util")

local M = {}

M.jump_to_root = function()
	local root_dir = util.find_git_ancestor(vim.fn.getcwd())

	if root_dir then
		vim.cmd("cd " .. root_dir)
	else
		error("Root directory not found")
	end
end

return M
