local path = require("telescope._extensions.jumper.path")

local M = {}

--- @param startpath string
--- @param func function
function M.search_ancestors(startpath, func)
	if func(startpath) then
		return startpath
	end

	local guard = 100
	for parent in path.iterate_parents(startpath) do
		-- Prevent infinite recursion if our algorithm breaks
		guard = guard - 1
		if guard == 0 then
			return
		end

		if func(parent) then
			return parent
		end
	end
end

--- @param startpath string
function M.find_git_ancestor(startpath)
	return M.search_ancestors(startpath, function(parent)
		-- Support git directories and git files (worktrees)
		if
			path.is_dir(path.join(parent, ".git"))
			or path.is_file(path.join(parent, ".git"))
		then
			return parent
		end
	end)
end

return M
