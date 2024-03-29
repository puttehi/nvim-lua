local readme_path = "README.md"

-- for appending (raw) or matching (escaped)
local inject_start = "<!-- DOCGEN_START -->"
local inject_start_pattern = "<!%-%- DOCGEN_START %-%->"

local inject_end = "<!-- DOCGEN_END -->"
local inject_end_pattern = "<!%-%- DOCGEN_END %-%->"

local function read_map()
    local maps = vim.api.nvim_exec(":map", true)
    return maps
end

local function str_to_table_lines(maps)
    return vim.split(maps, "\n", { trimempty = true })
end

local function lines_to_maps_table(lines)
    local maps_table = {}
    local pattern = "^(%a+)%s+([%a%p]+)%s+(.+)" -- mode  mapping   command/description
    for _, line in ipairs(lines) do
        local _, _, mode, mapping, cmd = string.find(line, pattern)
        -- if nothing was found, then let's assume the remainder is info on the next line
        if mode == nil or mapping == nil or cmd == nil then
            local prev_index = #maps_table -- must be length as we are filling it up
            maps_table[prev_index].info = line
        else
            table.insert(maps_table, {
                mode = mode,
                mapping = mapping,
                cmd = cmd,
                original = line,
                info = ""
            })
        end
    end
    return maps_table
end

local function cmp_mode_and_mapping(lhs, rhs)
    -- concat mode and mapping to effectively sort by mode first (alphabetically)
    return lhs.mode .. lhs.mapping < rhs.mode .. rhs.mapping
end

-- Sort by mode first, then by mapping
local function sort_maps_table(maps_table)
    table.sort(maps_table, cmp_mode_and_mapping)
    return maps_table
end

local function lstrip(str)
    return string.match(str, "^%s*(.*)")
end

local function lstrip_asterisk(str)
    return string.match(str, "^%s*%**[ ]*(.*)")
end

-- Pipes still break markdown tables, even in code blocks
local function escape_pipes(str)
    return string.gsub(str, "|", "\\%1")
end

local function surround_with_code_ticks(str)
    if str == nil then
        str = ""
    end
    return "`" .. str .. "`"
end

local function maps_table_to_markdown_table(maps_table, opts)
    opts                         = opts or {}
    local hide_which_key_hiddens = opts.hide_which_key_hiddens or true
    local which_key_hidden_char  = "Þ"

    local hide_which_key_builtin_groups = opts.hide_which_key_builtin_groups or true

    local hide_plug_mapping_links = opts.hide_plug_mapping_links or true

    local headers = "| mode | mapping | info | command |"
    local spacer  = "| ---- | ------- | ---- | ------- |"
    local content = ""

    local row_template = "| %s | %s | %s | %s |\n"
    for _, v in ipairs(maps_table) do repeat
            if hide_which_key_hiddens and string.find(v.info, which_key_hidden_char) then
                do break end -- continue?
            end
            if hide_which_key_builtin_groups and string.find(v.cmd, 'require%("which%-key"%)%.show') then
                do break end
            end
            if hide_plug_mapping_links and string.find(v.mapping, "<Plug>") then
                do break end
            end
            local mode    = escape_pipes(surround_with_code_ticks(lstrip(v.mode)))
            local mapping = escape_pipes(surround_with_code_ticks(lstrip(v.mapping)))
            local info    = escape_pipes(lstrip(v.info))
            local cmd     = escape_pipes(surround_with_code_ticks(lstrip_asterisk(v.cmd)))
            content       = content ..
                string.format(row_template, mode, mapping, info, cmd)
        until true
    end

    return headers .. "\n" .. spacer .. "\n" .. content
end

local function read_file(path)
    local f = assert(io.open(path, "r"))
    local contents = f:read("*all")
    f:close()
    return contents
end

local function inject_docs(readme, str)
    local _, start_j = string.find(readme, inject_start_pattern)
    local end_i, _ = string.find(readme, inject_end_pattern)

    local injected = ""

    if start_j and end_i then
        local until_start_j = string.sub(readme, 0, start_j) -- from start of document to end of start tag
        local remainder = string.sub(readme, end_i) -- from end of end tag to end of document
        injected = until_start_j .. "\n" .. str .. remainder
    else
        -- Tags were not found, append with tags
        injected = readme .. "\n" .. inject_start .. "\n" .. str .. inject_end .. "\n"
    end

    return injected
end

local function write_to_file(path, str)
    local f = assert(io.open(path, "w"))
    f:write(str)
    f:close()
end

local maps = read_map()
local lines_as_table = str_to_table_lines(maps)
local maps_as_table = lines_to_maps_table(lines_as_table)

local sorted = sort_maps_table(maps_as_table)

local md_table = maps_table_to_markdown_table(sorted)

local readme_contents = read_file(readme_path)
local injected = inject_docs(readme_contents, md_table)

write_to_file(readme_path, injected)
