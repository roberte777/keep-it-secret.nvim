--make a new auto command group for this plugin in lua
-- local grp = vim.api.nvim_create_augroup("keep_it_secret", {
-- 	clear = true,
-- })
-- vim.api.nvim_create_autocmd("buffer-check", {
-- 	group = grp,
--     command =
-- })
-- vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("keep-it-secret").show_warning_if_needed(".env")
	end,
})
