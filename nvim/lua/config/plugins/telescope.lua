local builtin = require("telescope.builtin")

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Always include dotfiles in ripgrep, but never search inside .git
local grep_args = { "--hidden", "-g", "!.git" }

-- Gitignored .env* files (e.g. .env, .env.local), as paths relative to git_root
local function ignored_env_files(git_root)
	local out = vim.fn.systemlist({
		"git",
		"-C",
		git_root,
		"ls-files",
		"--others",
		"--ignored",
		"--exclude-standard",
		"--directory",
	})
	if vim.v.shell_error ~= 0 then
		return {}
	end
	local files = {}
	for _, f in ipairs(out) do
		if f:match("^%.env[^/]*$") or f:match("/%.env[^/]*$") then
			table.insert(files, f)
		end
	end
	return files
end

-- Custom live_grep function to search all non-ignored files in the git root,
-- plus any gitignored .env* files
local function live_grep_git_root()
	local git_root = find_git_root()
	if not git_root then
		return
	end
	-- ripgrep searches explicitly named files regardless of .gitignore
	local dirs = { git_root }
	for _, f in ipairs(ignored_env_files(git_root)) do
		table.insert(dirs, git_root .. "/" .. f)
	end
	builtin.live_grep({
		search_dirs = dirs,
		additional_args = grep_args,
	})
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- Find all non-ignored files (tracked and untracked), plus any .env* files
local function project_files()
	vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
	if vim.v.shell_error ~= 0 then
		return builtin.find_files({ hidden = true, file_ignore_patterns = { "^%.git/" } })
	end
	builtin.find_files({
		find_command = {
			"sh",
			"-c",
			"{ git ls-files --cached --others --exclude-standard;"
				.. " git ls-files --others --ignored --exclude-standard --directory"
				.. " | grep -E '(^|/)\\.env[^/]*$'; } | sort -u",
		},
	})
end

local function live_grep_cwd()
	builtin.live_grep({ additional_args = grep_args })
end

vim.keymap.set("n", "<leader>pf", project_files, { desc = "Search by [P]roject [F]iles" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search by [G]it [F]iles in current directory" })
vim.keymap.set("n", "<leader>sf", live_grep_cwd, { desc = "[S]earch by [F]iles in current directory" })
vim.keymap.set("n", "<leader>ps", ":LiveGrepGitRoot<cr>", { desc = "[P]roject [S]earch" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
