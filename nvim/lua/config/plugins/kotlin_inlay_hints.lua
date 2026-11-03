-- Neovim 0.12 can retain old inlay-hint extmarks when the server returns new
-- hints for the same buffer version (for example, after Kotlin re-indexes).
-- The cached hints change, but the already-applied extmarks do not.
local original = vim.lsp.inlay_hint.on_inlayhint

local function label(hint)
	if type(hint.label) == "string" then
		return hint.label
	end
	local parts = {}
	for _, part in ipairs(hint.label) do
		parts[#parts + 1] = part.value
	end
	return table.concat(parts)
end

vim.lsp.inlay_hint.on_inlayhint = function(err, result, ctx)
	local ret = original(err, result, ctx)
	local client = ctx and vim.lsp.get_client_by_id(ctx.client_id)
	local bufnr = ctx and ctx.bufnr
	local ns = vim.api.nvim_get_namespaces()["nvim.lsp.inlayhint"]
	if err or not client or client.name ~= "kotlin_lsp" or not bufnr or not ns then
		return ret
	end

	local marks = vim.api.nvim_buf_get_extmarks(bufnr, ns, 0, -1, { details = true })
	if #marks == 0 then
		return ret
	end

	local current = {}
	for _, entry in ipairs(vim.lsp.inlay_hint.get({ bufnr = bufnr })) do
		local hint = entry.inlay_hint
		local key = hint.position.line .. ":" .. hint.position.character
		current[key] = (current[key] or "")
			.. (hint.paddingLeft and " " or "")
			.. label(hint)
			.. (hint.paddingRight and " " or "")
	end

	for _, mark in ipairs(marks) do
		local text = {}
		for _, chunk in ipairs(mark[4].virt_text or {}) do
			text[#text + 1] = chunk[1]
		end
		if current[mark[2] .. ":" .. mark[3]] ~= table.concat(text) then
			-- Reset only when rendered hints disagree with the latest LSP result.
			-- Re-enabling requests fresh hints; doing this unconditionally would loop.
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			break
		end
	end
	return ret
end
