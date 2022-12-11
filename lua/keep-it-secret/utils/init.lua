local M = {}

function M.create_win()
	local width = 60
	local height = 10
	local buf = vim.api.nvim_create_buf(false, true)
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	--create centered floating window
	local winid, win = require("plenary.popup").create(buf, {
		minwidth = width,
		minheight = height,
		line = math.floor(((vim.o.lines - height) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		borderchars = borderchars,
	})
	--set buffer contents
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
		"WARNING!:",
		"",
		"This file contains sensitive information.",
		"If you are sharing your screen, you should not enter.",
		"Press 'y' to enter or 'n' to quit.",
	})
	return { popup_bufnr = buf, popup_winid = winid }
end

return M
