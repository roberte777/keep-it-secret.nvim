vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("keep-it-secret").show_warning_if_needed()
	end,
})
