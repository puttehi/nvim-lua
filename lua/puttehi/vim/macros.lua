local function parse(macro)
    return vim.api.nvim_replace_termcodes(macro, true, true, true)
end

local registers_with_macros = {
    -- TypeScript class public property based on property cursor is on
    ["p"] = parse(
        "0f_<C-e>lvwhyopublic get <Esc>pa(): any { return this._<Esc>pa }<Esc>kvbyj0f:<C-e>llvwhh p<Esc>j"
    ),
}

for reg, macro in pairs(registers_with_macros) do
    vim.fn.setreg(reg, macro)
end
