local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local state = require("telescope.actions.state")

--- @param _ number
--- @param opts jumper.Opts
return function(_, opts)
	pickers
		.new(_, {
			prompt_title = "Directories",
			finder = finders.new_table({
				results = opts.dirs or {},
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selection = state.get_selected_entry()
					local dir = selection[1]

					vim.fn.chdir(dir)
				end)

				return true
			end,
		})
		:find()
end
