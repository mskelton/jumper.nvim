local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local state = require("telescope.actions.state")
local path = require("telescope._extensions.jumper.path")
local util = require("telescope._extensions.jumper.util")

--- @param root_dir string
--- @param patterns string[]
local function find_directories(root_dir, patterns)
	local results = { "." }

	for _, pattern in ipairs(patterns) do
		--- @diagnostic disable-next-line: param-type-mismatch
		local dirs = vim.fn.globpath(root_dir, path.to_dir(pattern), 0, 1)
		assert(type(dirs) == "table")

		--- Remove the root directory from the results
		for _, dir in ipairs(dirs) do
			table.insert(results, string.sub(dir, #root_dir + 2, -2))
		end
	end

	return results
end

--- @param _ number
--- @param opts jumper.Opts
return function(_, opts)
	--- Get a stable root directory for switching back and forth
	local root_dir = util.find_git_ancestor(vim.fn.getcwd())
	if not root_dir then
		root_dir = vim.fn.getcwd()
	end

	local patterns = opts.patterns or {}
	local results = find_directories(root_dir, patterns)

	pickers
		.new(_, {
			prompt_title = "Directories",
			finder = finders.new_table({ results = results }),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selection = state.get_selected_entry()
					local dir = selection[1]

					if dir == "." then
						dir = root_dir
					end

					vim.fn.chdir(dir)
				end)

				return true
			end,
		})
		:find()
end
