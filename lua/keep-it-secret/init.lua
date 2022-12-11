local Path = require("plenary.path")
local config_path = vim.fn.stdpath("config")
local user_config = string.format("%s/keep-it-secret.json", config_path)

local M = {
	wildcards = { ".*(.env)$", ".*(.secret)$" },
	enabled = false,
}
function M.save(enabled)
	Path:new(user_config):write(vim.fn.json_encode({ enabled = enabled }), "w")
end

local function read_config(local_config)
	return vim.json.decode(Path:new(local_config):read())
end

function M.setup(opts)
	opts = opts or {}
	M.enabled = opts.enabled or M.enabled
	local ok, config = pcall(read_config, user_config)
	if ok then
		M.enabled = config.enabled
	end
	M.wildcards = opts.wildcards or M.wildcards
end

function M.toggle()
	M.enabled = not M.enabled
	M.save(M.enabled)
end

Win_id = nil
Buf_id = nil
Filename = nil

function M.show_warning_if_needed()
	if not M.enabled then
		return
	end

	local filename = vim.fn.expand("%:t")

	-- Check if the filename matches any of the configured wildcards
	for _, wildcard in ipairs(M.wildcards) do
		if string.match(filename, wildcard) then
			if Filename and string.match(filename, Filename) then
				Filename = nil
				return
			end
			Filename = filename
			-- move user to empty buffer
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_set_current_buf(buf)

			local win_info = require("keep-it-secret.utils").create_win()
			Win_id = win_info.popup_winid
			Buf_id = win_info.popup_bufnr
			-- set keymap to close window
			vim.api.nvim_buf_set_keymap(
				Buf_id,
				"n",
				"y",
				--close window and temp buffer, move user to original buffer
				":q<CR>:bd<CR>",
				{ noremap = true, silent = true }
			)
			-- set keymap for "n" if user does not want to enter secret file
			vim.api.nvim_buf_set_keymap(Buf_id, "n", "n", ":q<CR>:bd<CR>:bd<CR>", { noremap = true, silent = true })
			break
		end
	end
end

function M.close_menu()
	vim.api.nvim_win_close(Win_id, true)
end

return M
