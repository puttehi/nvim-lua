function ColorMyPencils(color)
	color = color or "puttehi-dark"
	vim.cmd.colorscheme(color)

    --transparent bg if no config option
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

