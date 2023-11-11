local M = {}

local is_windows = vim.loop.os_uname().version:match("Windows")

function M.exists(filename)
	local stat = vim.loop.fs_stat(filename)
	return stat and stat.type or false
end

function M.is_dir(filename)
	return M.exists(filename) == "directory"
end

function M.is_file(filename)
	return M.exists(filename) == "file"
end

function M.is_fs_root(path)
	if is_windows then
		return path:match("^%a:$")
	else
		return path == "/"
	end
end

--- @param path string
--- @return string?
function M.dirname(path)
	local strip_dir_pat = "/([^/]+)$"
	local strip_sep_pat = "/$"
	if not path or #path == 0 then
		return
	end
	local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
	if #result == 0 then
		if is_windows then
			return path:sub(1, 2):upper()
		else
			return "/"
		end
	end
	return result
end

function M.join(...)
	return table.concat(vim.tbl_flatten({ ... }), "/")
end

-- Iterate the path until we find the rootdir.
function M.iterate_parents(path)
	local function it(_, v)
		if v and not M.is_fs_root(v) then
			v = M.dirname(v)
		else
			return
		end
		if v and vim.loop.fs_realpath(v) then
			return v, path
		else
			return
		end
	end
	return it, path, path
end

function M.to_dir(path)
	if path:sub(-1) == "/" then
		return path
	else
		return path .. "/"
	end
end

return M
