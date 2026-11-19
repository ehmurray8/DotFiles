-- Oil shows every file that git does not ignore (including dotfiles such as
-- .gitlab-ci/), always shows .env* files, and always hides .git and .DS_Store.
-- Press `g.` inside an oil buffer to temporarily reveal everything.

-- dir -> { time = ms, ignored = set | nil }
local cache = {}
local TTL = 1000

-- Oil calls is_hidden_file once per entry, so run git once per directory render
-- and reuse the result for a short while.
local function ignored_set(dir)
	local now = vim.uv.now()
	local c = cache[dir]
	if c and now - c.time < TTL then
		return c.ignored
	end

	local res = vim.system(
		{ "git", "-C", dir, "ls-files", "--others", "--ignored", "--exclude-standard", "--directory" },
		{ text = true }
	):wait()

	local set
	if res.code == 0 then
		set = {}
		local has_env = {}
		for line in vim.gsplit(res.stdout, "\n", { plain = true, trimempty = true }) do
			-- Only top-level entries ("foo" or "foo/") are ignored themselves.
			-- Deeper paths mean the parent directory is not ignored.
			local name = line:match("^([^/]+)/?$")
			if name then
				set[name] = true
			end
			-- Keep directories that contain an ignored .env* file visible
			local parent = line:match("^([^/]+)/.*%.env[^/]*$")
			if parent then
				has_env[parent] = true
			end
		end
		for name in pairs(has_env) do
			set[name] = nil
		end
	end

	cache[dir] = { time = now, ignored = set }
	return set
end

require("oil").setup({
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name, bufnr)
			if name:match("^%.env") then
				return false
			end
			local dir = require("oil").get_current_dir(bufnr)
			if not dir then
				return vim.startswith(name, ".")
			end
			local ignored = ignored_set(dir)
			if ignored == nil then
				-- Not a git repository: fall back to hiding dotfiles
				return vim.startswith(name, ".")
			end
			return ignored[name] == true
		end,
		is_always_hidden = function(name)
			return name == ".." or name == ".git" or name == ".DS_Store"
		end,
	},
})
