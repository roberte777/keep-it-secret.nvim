local M = {
	wildcards = { ".*.env", ".*.secret" },
	enabled = true,
}

function M.setup(opts)
	opts = opts or {}
	M.wildcards = opts.wildcards or M.wildcards
	M.enabled = opts.enabled or M.enabled
end

function M.toggle()
	M.enabled = not M.enabled
end

function M.show_warning_if_needed()
	if not M.enabled then
		return
	end

	local filename = vim.fn.expand("%:t")

	-- Check if the filename matches any of the configured wildcards
	for _, wildcard in ipairs(M.wildcards) do
		if string.match(filename, wildcard) then
			local choice = vim.fn.confirm(
				"Warning! You are about to show a file that could contain secrets. Would you like to continue?",
				"&Yes\n&No"
			)
			if choice == 2 then
				vim.api.nvim_command("bd")
			end
			break
		end
	end
end

return M
