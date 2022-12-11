local M = {}
local enabled = true
function M.test()
	print("test")
end

function M.toggle()
	enabled = not enabled
end

function M.show_warning_if_needed()
	if not enabled then
		return
	end

	local wildcards = { ".*.env", ".*.secret" }
	local filename = vim.fn.expand("%:t")

	-- Check if the filename matches any of the configured wildcards
	for _, wildcard in ipairs(wildcards) do
		if string.match(filename, wildcard) then
			-- Show the warning message
			local answer = vim.fn.input(
				"Warning! You are about to show a file that could contain secrets. Would you like to continue? [y/n]"
			)
			if answer:lower() ~= "y" then -- if the user doesn't want to open the file, close the buffer
				vim.api.nvim_command("bd")
			end
			break
		end
	end
end

function M.is_enabled()
	print(enabled)
end

return M
