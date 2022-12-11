local M = {}
local enabled = true
function M.test()
	print("test")
end

function M.toggle()
	enabled = not enabled
end

function M.show_warning_if_needed(filename)
	if not enabled then
		return
	end

	local wildcards = { "*.env", "*.secret" }

	-- Check if the filename matches any of the configured wildcards
	for _, wildcard in ipairs(wildcards) do
		if vim.fn.match(filename, wildcard) then
			-- Show the warning message
			vim.api.nvim_command(
				"echo 'Warning! You are about to show a file that could contain secrets. Would you like to continue?'"
			)
			break
		end
	end
end

function M.is_enabled()
	print(enabled)
end

function M.register_buffer_attach_callback()
	local options = {
		on_file_opened = M.show_warning_if_needed,
	}
	vim.api.nvim_buf_attach(0, options)
end

M.register_buffer_attach_callback()
return M
