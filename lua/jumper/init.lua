local util = require("jumper.util")

local M = {}

M.jump_to_root = function()
	local root_dir = util.find_git_ancestor(vim.fn.getcwd())

	if root_dir then
		vim.fn.chdir(root_dir)
	else
		error("Root directory not found")
	end
end

M.jump_to_current_directory = function()
	vim.fn.chdir(vim.fn.expand("%:p:h"))
end

return M
